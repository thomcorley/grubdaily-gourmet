class JekyllPostsController < ApplicationController
  before_action :authenticate

	def generate
		@recipe = Recipe.find(params[:recipe_id])
		@category = @recipe.tags.split(",").first.strip
		@tags = @recipe.tags.split(",")
	end
end
