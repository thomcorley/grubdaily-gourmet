class RecipesController < ApplicationController
  before_action :set_recipe, only: [
    :show, :edit, :update, :destroy, :publish, :unpublish, :image, :as_yaml
  ]

  before_action :authenticate, except: [:show, :feed]

  caches_page :show

  def index
    @recipes = Recipe.all.order(updated_at: :asc)
  end

  def show
    unless @recipe
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end

    @ingredient_sets = @recipe.ingredient_sets.order(position: :asc)

    @introduction_paragraphs = @recipe.introduction.split("\n").map do |paragraph|
      MarkdownConverter.convert(paragraph)
    end

    @method_steps_with_description = @recipe.method_steps.order(:position).map do |method_step|
      OpenStruct.new(
        method_step: method_step,
        description: MarkdownConverter.convert(method_step.description)
      )
    end

    @ingredient_entries = @recipe.ingredient_entries

    @tags = @recipe.tags

    @prev_recipe = Recipe.find_by_id(@recipe.id - 1)
    @next_recipe = Recipe.find_by_id(@recipe.id + 1)
    @subscriber_count = subscriber_count

    @other_recipes = if @recipe.related_entries.any?
      @recipe.related_entries.first(4)
    else
      RecommendedEntries.find_for(entry: @recipe.entry, size: 4)
    end
  end

  def edit
    @related_entries = @recipe.related_entries
  end

  def update
    respond_to do |format|
      if @recipe.update!(recipe_params.except('tag_names'))
        find_or_create_entry
        expire_recipe_caches
        @recipe.process_image_variants

        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish
    @recipe.publish!
    redirect_to recipe_path(@recipe), flash: { notice: "Recipe successfully published!" }
  end

  def unpublish
    @recipe.unpublish!
    redirect_to recipe_path(@recipe), flash: { notice: "Recipe unpublished" }
  end

  def destroy
    @recipe.destroy
    redirect_to recipe_index_path, flash: { notice: "Recipe was successfully deleted" }
  end

  def feed
    @recipes = Recipe.marked_for_promotion
                     .where("marked_for_promotion_at <= ?", Date.today.beginning_of_day)
                     .order(marked_for_promotion_at: :desc)

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def image

  rescue ActiveStorage::FileNotFoundError
    render html: '<img src="/images/placeholder-square.jpg">'
  end

  def as_yaml
    render plain: @recipe.as_yaml
  end

  private

  def authenticate
    not_found unless admin_session?
  end

  def set_recipe
    # Confusingly, `recipe_title` is usually the permalink of the recipe, but sometimes the ID
    if params["recipe_path"]
      @recipe = Recipe.all.find { |recipe| recipe.permalink == "/#{params["recipe_path"]}" }
    elsif params[:id]
      @recipe = Recipe.find_by_id(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recipe_params
    params.require(:recipe).permit(
      :title,
      :summary,
      :total_time,
      :introduction,
      :serves,
      :makes,
      :makes_unit,
      :recipe_type,
      :tag_names,
      :image,
      :published_at,
      :marked_for_promotion_at,
      :related_recipe_ids,
      :related_recipes_heading,
      :nutrition,
      :show_nutrition,
    ).merge(related_recipe_ids: JSON.parse(params[:related_recipe_ids]))
  end

  def entry_params
    params.require(:recipe).permit(
      :title,
      :summary,
      :introduction,
      :published_at,
      :marked_for_promotion_at
    )
  end

  def expire_recipe_caches
    expire_page controller: :home, action: [:index, :recipe_index]
    expire_page controller: :sitemap, action: :show
    expire_tags
    expire_page action: :show, id: @recipe.id
    expire_page @recipe.permalink
  end

  def expire_tags
    @recipe.tags.map(&:name).each do |tag_name|
      expire_page "/tags/#{tag_name}"
    end
  end

  def find_or_create_entry
    entry = Entry.find_or_create_by!(entryable: @recipe)
    entry_params = recipe_params.slice(:title, :summary, :published_at, :marked_for_promotion_at)
    entry_params[:content] = recipe_params[:introduction]

    entry.update(entry_params)
    entry.tags = recipe_params['tag_names']
  end
end
