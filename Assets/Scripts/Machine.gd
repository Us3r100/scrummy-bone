extends Node2D

@onready var animation_player := $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if animation_player:
		animation_player.play("PullCapsule")
	else:
		print("Aniplayer not found")
