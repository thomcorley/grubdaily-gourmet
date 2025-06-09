json.extract! recipe, :id, :title, :summary, :total_time, :introduction, :serves, :makes, :makes_unit, :type, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
