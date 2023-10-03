class_name ToyDefs

enum Rarity {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}
static var rarity_weights: Array[float] = [45, 30, 19, 5, 1]

class Toy:
	var toy_name:String
	var filename:String
	var rarity:Rarity
	var theme:String
	
	func _init(p_toy_name:String, p_filename:String, p_rarity:Rarity, p_theme:String):
		toy_name = p_toy_name
		filename = p_filename
		rarity = p_rarity
		theme = p_theme
	
class ToyTheme:
	var theme_name:String
	var toys:Array[Toy]
	
	func _init(p_theme_name:String, p_toys:Array[Toy]):
		theme_name = p_theme_name
		toys = p_toys
	
