extends Node2D

@export var theme_name: String

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var machine_rng : MachineRng = %MachineRng
@onready var toy_sprite : Sprite2D = $Sprite/ToySprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if animation_player:
		animation_player.play("PullCapsule")
	else:
		print("Aniplayer not found")

func pull():
	var pulled_toy := machine_rng.pull_toy(theme_name)
	var sprite_texture : Texture2D = load(ToyDefs.toy_sprites_path + pulled_toy.filename)
	toy_sprite.texture = sprite_texture
	# TODO: remove printout
	print(pulled_toy.toy_name)
	if animation_player:
		animation_player.play("PullCapsule")
	else:
		print("Aniplayer not found")

	
