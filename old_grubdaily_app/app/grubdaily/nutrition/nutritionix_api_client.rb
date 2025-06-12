module Nutrition
  class NutritionixApiClient
    URL = "https://trackapi.nutritionix.com/v2/natural/nutrients"
    KEY = Rails.application.credentials[:nutritionix][:key]
    USER_ID = Rails.application.credentials[:nutritionix][:user_id]

    def self.get_json_response(ingredient)
      new(ingredient: ingredient).get_response
    end

    attr_reader :fmt, :ingredient

    def initialize(fmt: NutritionixApiFormat, ingredient:)
      @fmt = fmt
      @ingredient = ingredient
    end

    def get_response
      response = HTTParty.post(URL, {
        headers: {
          'x-app-id' => USER_ID,
          'x-app-key' => KEY,
          'x-remote-user-id' => '1',
          'Content-Type' => 'application/json'
        },
        body: {
          query: ingredient
        }.to_json
      })

      fmt.standardise_format(response).to_json
    end
  end
end
