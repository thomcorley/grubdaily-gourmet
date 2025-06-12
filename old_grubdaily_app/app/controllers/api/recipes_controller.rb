module Api
  class RecipesController < ApplicationController
    before_action :set_default_format

    def index
      recipes = Recipe.all

      respond_to do |format|
        format.json {
          render json: recipes, include: [{ingredient_sets: :ingredient_entries}, :method_steps]
        }
      end
    end

    def sample
      recipe = Recipe.all.sample

      respond_to do |format|
        format.json {
          render json: recipe, include: [{ingredient_sets: :ingredient_entries}, :method_steps]
        }
      end
    end

    def search
      unless params[:q]
        render plain: "Missing `q` param", status: 422
      else
        result = RecipeSearch.new(query: params[:q]).result

        respond_to do |format|
          format.json {
            render json: result, include: [{ingredient_sets: :ingredient_entries}, :method_steps]
          }
        end
      end
    end

    private

    def set_default_format
      request.format = :json
    end
  end
end
