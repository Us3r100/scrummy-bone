extends Node2D

@onready var animation_player := $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Click"):
		animation_player.play("PullCapsule")
