class IngredientEntriesController < ApplicationController
  before_action :set_instance_variables, only: [:show, :edit, :touch, :update, :destroy]
  before_action :authenticate

  def index
    @ingredient_entries = IngredientEntry.all

    @old_ingredient_entries = IngredientEntry
                                .where("updated_at < ?", Date.new(2020,5,31))
                                .order(original_string: :asc)

    @recently_updated_ingredient_entries = IngredientEntry
                                .where("updated_at >= ?", Date.today)
                                .order(updated_at: :desc)
                                .limit(5)

    @entries_updated = @ingredient_entries.count - @old_ingredient_entries.count
  end

  def show
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient_set = @recipe.ingredient_sets.find(params[:ingredient_set_id])
    @ingredient_entry = @ingredient_set.ingredient_entries.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient_set = @recipe.ingredient_sets.find(params[:ingredient_set_id])
    @ingredient_entry = @ingredient_set.ingredient_entries.create!(ingredient_entry_params)
    redirect_to(recipe_url(@recipe))
  end

  def edit
  end

  def touch
    @ingredient_entry.touch
    redirect_to ingredient_entries_path, notice: 'Timestamp updated'
  end

  def update
    respond_to do |format|
      if @ingredient_entry.update(ingredient_entry_params)
        format.html { redirect_to edit_recipe_ingredient_set_path(@recipe, @ingredient_set), notice: 'Ingredient entry was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @ingredient_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ingredient_entry.destroy
    redirect_to recipe_url(@recipe), flash: { notice: "Ingredient entry was successfully destroyed." }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance_variables
      @ingredient_entry = IngredientEntry.find(params[:id])
      @ingredient_set = IngredientSet.find(params[:ingredient_set_id])
      @recipe = @ingredient_entry.ingredient_set.recipe
      @ingredient = @ingredient_entry.ingredient
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_entry_params
      params.require(:ingredient_entry).permit(:quantity, :unit, :size, :modifier, :original_string, :ingredient_name, :quantityless, :position)
    end
end
