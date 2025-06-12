class IngredientEntryTestData
  ENTRIES = [
    {
      expected_output: "1 carrot",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [1, nil,  nil, "carrot", nil, false]
    },
    {
      expected_output: "100 g plain flour",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [100, "g",  nil, "plain flour", nil, false]
    },
    {
      expected_output: "10 g carrot, diced",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [10, "g",  nil, "carrot", "diced", false]
    },
    {
      expected_output: "25 large tomatoes, peeled and chopped",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [25, nil,  "large", "tomatoes", "peeled and chopped", false]
    },
    {
      expected_output: "3 handfuls basil, leaves picked",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [3, "handful",  nil, "basil", "leaves picked", false]
    },
    {
      expected_output: "3 large cloves garlic, chopped",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [3, "large clove",  nil, "garlic", "chopped", false]
    },
    {
      expected_output: "vegetable oil, for frying",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [nil, nil,  nil, "vegetable oil, for frying", nil, true]
    },
    {
      expected_output: "2 small cloves garlic",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [2, "small clove",  nil, "garlic", nil, false]
    },
    {
      expected_output: "750 g cavolo nero",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [750, "g",  nil, "cavolo nero", nil, false]
    },
    {
      expected_output: "1 tsp extra virgin olive oil",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [1, "tsp",  nil, "extra virgin olive oil", nil, false]
    },
    {
      expected_output: "1 pinch ground asafoetida",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [1, "pinch",  nil, "ground asafoetida", nil, false]
    },
    {
      expected_output: "sea salt and freshly cracked black pepper",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [nil, nil,  nil, "sea salt and freshly cracked black pepper", nil, true]
    },
    {
      expected_output: "½ leek",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [0.5, nil,  nil, "leek", nil, false]
    },
    {
      expected_output: "250 g cream cheese",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [250, "g",  nil, "cream cheese", nil, false]
    },
    {
      expected_output: "2 medium banana shallots, finely chopped",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [2, nil,  "medium", "banana shallots", "finely chopped", false]
    },
    {
      expected_output: "1 handful red seedless grapes",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [1, "handful",  nil, "red seedless grapes", nil, false]
    },
    {
      expected_output: "1 bay leaf",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [1.0, "",  "", "bay leaf", "", false]
    },
    {
      expected_output: "½ lime, juice of",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [0.5, "",  "", "lime", "juice of", false]
    },
    {
      expected_output: "¼ tsp chilli powder",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [0.25, "tsp",  "", "chilli powder", "", false]
    },
    {
      expected_output: "⅛ tsp chilli powder",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [0.125, "tsp",  "", "chilli powder", "", false]
    },
    {
      expected_output: "⅔ tsp chilli powder",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [0.666, "tsp",  "", "chilli powder", "", false]
    },
    {
      expected_output: "10 g cavolo nero (black kale)",
      # [:quantity, :unit, :size, :ingredient, :modifier, :quantityless]
      params: [10, "g",  "", "cavolo nero", "black kale", false]
    },
  ]
end
