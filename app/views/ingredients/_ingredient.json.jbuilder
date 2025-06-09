json.extract! ingredient, :id, :name, :synonyms, :content, :animal_status, :nutrition, :publishable, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
