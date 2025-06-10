class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  before_action :authenticate, except: :show

  def index
    @ingredients = Ingredient.all
  end

  def show
    entry_sql = <<-SQL
      LOWER(ingredient_entries.ingredient_name) LIKE '%#{@ingredient.name.downcase}%'
    SQL

    @recipes = Recipe.where("LOWER(title) LIKE '%#{@ingredient.name.downcase.singularize}%'").or(
                 Recipe.where("LOWER(title) LIKE '%#{@ingredient.name.downcase.pluralize}%'")
               ).limit(3)

    @recipes += Recipe.joins(ingredient_sets: :ingredient_entries)
                      .where(entry_sql)
                      .limit(3)

    @recipes = @recipes.uniq.first(4)

    @introduction_paragraphs = @ingredient.content.split("\n").map do |paragraph|
      MarkdownConverter.convert(paragraph)
    end

    fresh_when(@ingredient)
  end

  def new
    @ingredient = Ingredient.new
  end

  def edit
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to ingredient_url(@ingredient), notice: "Ingredient was successfully created." }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1 or /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to ingredient_url(@ingredient), notice: "Ingredient was successfully updated." }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1 or /ingredients/1.json
  def destroy
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to ingredients_url, notice: "Ingredient was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def publish
    @ingredient.publish!
    redirect_to ingredient_path(@ingredient), flash: { notice: "Ingredient successfully published!" }
  end

  def unpublish
    @ingredient.unpublish!
    redirect_to ingredient_path(@ingredient), flash: { notice: "Ingredient unpublished!" }
  end

  private

    def set_ingredient
      if params["ingredient_path"]
        @ingredient = Ingredient.find_by(name: params["ingredient_path"])
      elsif params[:id]
        @ingredient = Ingredient.find_by(id: params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def ingredient_params
      params.require(:ingredient).permit(
        :name,
        :synonyms,
        :content,
        :animal_status,
        :nutrition,
        :publishable,
        :image,
        :related_recipes_heading
      )
    end
end
