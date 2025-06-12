class Units
	METRIC = %w(g kg l ml litre gram kilogram)
	IMPERIAL = %w(oz lb ounce pound tsp tbsp teaspoon tablespoon)
	PLURALISABLE = %w(clove cup glass glassful pinch handful bunch sprig rasher head)
	NON_SPACED = %w(g kg ml l oz lb)

	SPECIAL = [
		"small pinch", "large pinch", "generous pinch", "small handful", "large handful", "generous handful",
		"small clove", "large clove", "large glass", "small glass"
	]

	SPACED = [PLURALISABLE, SPECIAL, %w(litre gram kilogram ounce pound tsp tbsp teaspoon tablespoon)].flatten
	ALL = [METRIC, IMPERIAL, PLURALISABLE, SPECIAL].flatten.uniq
end
