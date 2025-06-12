# NOTE: this doesn't work, but I'm leaving it here for future reference
module Nutrition
  class ApiNinjasApiClient
    URL = "https://api.api-ninjas.com/v1/nutrition?query="

    def get_json_response
      response = HTTParty.get("#{url}#{ingredient_name}",
        headers: { "X-Api-Key" => KEY }
      )
      fmt.standardise_format(response[0]).to_json
    end
  end
end
