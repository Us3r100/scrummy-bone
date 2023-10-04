extends Sprite2D

@export var machine_rng: MachineRng
@onready var anim_state_machine:AnimationTree = $AnimationTree

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_state_machine.active = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Interact") && machine_rng:
		var toy = machine_rng.pull_toy("First Theme")
		print(toy.toy_name, " [", ToyDefs.Rarity.keys()[toy.rarity], "]")
	
	anim_state_machine["parameters/conditions/do_wiggle"] = Input.is_action_pressed("Interact")







