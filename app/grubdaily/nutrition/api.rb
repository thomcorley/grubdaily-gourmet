module Nutrition
  class Api
    def self.get_json(ingredient_entry_or_name)
      new(ingredient: ingredient_entry_or_name).get_json_response
    end

    attr_reader :ingredient, :fmt, :url

    def initialize(ingredient:, client: NutritionixApiClient)
      @ingredient = ingredient
      @client = client
    end

    def get_json_response
      @client.get_json_response(ingredient)
    end
  end
end
