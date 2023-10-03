class_name MachineRng
extends Node

@export var toy_repo: ToyRepository
var rng = RandomNumberGenerator.new()

func pull_toy(p_theme: String) -> ToyDefs.Toy:
	# Return null if toy_repo is not set
	if !toy_repo:
		return null
		
	var theme_index = toy_repo.find_theme_by_name(p_theme)
	# Return null if theme isn't found
	if theme_index < 0:
		return null
		
	# Array of toy names (String) grouped by rarity
	var possible_toys: Array[Array] = []
	for i in ToyDefs.Rarity.size():
		possible_toys.append([])
	
	# Grab every toy in the selected theme
	for toy_index in toy_repo.themes[theme_index].toys.size():
		var toy = toy_repo.themes[theme_index].toys[toy_index]
		possible_toys[toy.rarity].append(toy.toy_name)
		
	# Check what rarities are present
	var new_rarity_list: Array[int]
	var new_rarity_weights: Array[float]
	for i in possible_toys.size():
		if !possible_toys[i].is_empty():
			new_rarity_list.append(i)
			new_rarity_weights.append(ToyDefs.rarity_weights[i])
	
	# Pick rarity
	var selected_rarity: int = new_rarity_list[0]
	var rarity_weight_sum: float = 0
	for weight in new_rarity_weights:
		rarity_weight_sum += weight
	var result = rng.randf_range(0, rarity_weight_sum)
	for i in new_rarity_weights.size():
		if result > new_rarity_weights[i]:
			result -= new_rarity_weights[i]
		else:
			selected_rarity = new_rarity_list[i]
			break
	
	# Pick toy
	var toys = possible_toys[selected_rarity]
	var selected_toy: String = toys[rng.randi_range(0, toys.size()-1)]
	var selected_toy_index = toy_repo.find_toy_by_name(selected_toy).y
	return toy_repo.themes[theme_index].toys[selected_toy_index]
	
