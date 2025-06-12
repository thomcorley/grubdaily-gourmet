class IngredientSetsController < ApplicationController
  before_action :set_ingredient_set, only: [:show, :edit, :update, :destroy]
  before_action :set_recipe, only: [:new, :edit, :create, :update, :destroy]
  before_action :authenticate

  # GET /ingredient_sets
  # GET /ingredient_sets.json
  def index
    @ingredient_sets = IngredientSet.all
  end

  # GET /ingredient_sets/1
  # GET /ingredient_sets/1.json
  def show
  end

  # GET /ingredient_sets/new
  def new
    @ingredient_set = IngredientSet.new(recipe: @recipe)
  end

  # GET /ingredient_sets/1/edit
  def edit
    @recipe = @ingredient_set.recipe
  end

  # POST /ingredient_sets
  # POST /ingredient_sets.json
  def create
    @ingredient_set = IngredientSet.new(ingredient_set_params)

    respond_to do |format|
      if @ingredient_set.save
        format.html { redirect_to @recipe, notice: 'Ingredient set was successfully created.' }
        format.json { render :edit, status: :created, location: @ingredient_set }
      else
        format.html { render :new }
        format.json { render json: @ingredient_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredient_sets/1
  # PATCH/PUT /ingredient_sets/1.json
  def update
    respond_to do |format|
      if @ingredient_set.update(ingredient_set_params)
        format.html { redirect_to recipe_path(@ingredient_set.recipe), notice: 'Ingredient set was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /ingredient_sets/1
  # DELETE /ingredient_sets/1.json
  def destroy
    @ingredient_set.destroy
    respond_to do |format|
      format.html { redirect_to ingredient_sets_url, notice: 'Ingredient set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient_set
      @ingredient_set = IngredientSet.find(params[:id])
    end

    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_set_params
      permitted = params.require(:ingredient_set).permit(
        :title,
        :position,
        ingredient_entries_attributes: [:id, :position]
      )

      permitted.merge(recipe_id: params[:recipe_id])
    end
end
