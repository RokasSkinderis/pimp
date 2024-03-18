extends CharacterBody2D

@onready var target = position

var speed = 300

func _enter_tree():
	set_multiplayer_authority(get_parent().get_multiplayer_authority())
	$Label.text = str(get_multiplayer_authority())
	

func _ready():
	add_to_group("unit_group", true)

func _physics_process(delta):
	velocity = global_position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()
	
func _input(event):
	if event.is_action_released("set_rally"):
		set_rally(event.position)
		
#@rpc("any_peer", "call_local")
func set_rally(position):
	if get_multiplayer_authority() == multiplayer.get_unique_id():
		target = position
