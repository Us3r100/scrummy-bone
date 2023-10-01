class_name ToyRepository
extends Node

@export var print_on_load = false
@export var json_path = "res://Data/Toys.json"

var toys:Array[ToyDefs.Toy]
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
			toys.append_array(toys_in_theme)
	else:
		print("JSON Parse Error ", json.get_error_message(), " in ", json_text, " at line ", json.get_error_line())
	

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
