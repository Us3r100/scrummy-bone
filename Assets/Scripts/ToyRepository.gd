class_name ToyRepository
extends Node

@export var print_on_load = false
@export var json_path = "res://Data/Toys.json"

#var toys:Array[ToyDefs.Toy]
var themes:Array[ToyDefs.ToyTheme]

func load_from_json(json_path:String):
	var json_text = FileAccess.get_file_as_string(json_path)
	var json = JSON.new()
	var error = json.parse(json_text)
	if error == OK:
		var data_received = json.data
		assert(typeof(data_received) == TYPE_DICTIONARY, "Unexpected json format, must be type dict")
		var toydict = data_received as Dictionary
		# Create a theme object for each theme defined in the Json
		for theme in toydict["themes"]:
			var toys_in_theme:Array[ToyDefs.Toy]
			# Load all toys defined in the theme
			for toy in theme["toys"]:
				var toy_obj = ToyDefs.Toy.new(toy["toyName"], toy["toyImg"], toy["rarity"], theme["themeName"])
				toys_in_theme.append(toy_obj)
				
			var theme_obj = ToyDefs.ToyTheme.new(theme["themeName"], toys_in_theme)
			themes.append(theme_obj)
#			toys.append_array(toys_in_theme)
	else:
		print("JSON Parse Error ", json.get_error_message(), " in ", json_text, " at line ", json.get_error_line())
		assert(false)
	
# Adds a theme to the theme array if a them with the same name does not already exist
# returns bool: whether or not the theme was added
func add_theme(p_theme:ToyDefs.ToyTheme) -> bool:
	var should_add_theme = (find_theme_by_name(p_theme.theme_name) == -1)
	if should_add_theme: 
		themes.append(p_theme)
	return should_add_theme

# Adds a toy to the corresponding theme. Toy can only be added if theme already exists and
# a toy of the same name does not already exist within the theme.
# returns bool: whether or not the toy was added
func add_toy(p_toy:ToyDefs.Toy) -> bool:
	var theme_index = find_theme_by_name(p_toy.theme) 
	var found_toy_index = find_toy_by_name(p_toy.toy_name)
	var should_add_toy = theme_index != -1 and found_toy_index == Vector2(-1, -1)
	if should_add_toy:
		themes[theme_index].toys.append(p_toy)
	return should_add_toy
	

# Finds the index of the theme with the given theme name
func find_theme_by_name(p_theme_name:String) -> int:
	var index := -1
	for i in themes.size():
		if themes[i].theme_name == p_theme_name:
			index = i
			break
	return index
	
# Finds the theme index and corresponding toy index of a toy by name
# returns Vector2: where x is the theme index and y is the toy index within the theme
func find_toy_by_name(p_toy_name:String) -> Vector2i:
	var ret := Vector2i(-1, -1)
	for i in themes.size():
		for j in themes[i].toys.size():
			if themes[i].toys[j].toy_name == p_toy_name:
				ret.x = i
				ret.y = j
				break
	return ret
	

func print_toys():
	for theme in themes:
		print(theme.theme_name, ":")
		for toy in theme.toys:
			print(toy.toy_name, " [", ToyDefs.Rarity.keys()[toy.rarity], "]")
		print()

# Called when the node enters the scene tree for the first time.
func _ready():
	load_from_json(json_path)
	if print_on_load:
		print_toys()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
