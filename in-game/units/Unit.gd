extends CharacterBody2D

@onready var target = position
@onready var authorityId = self.get_multiplayer_authority()

var speed = 300

func _ready():
	add_to_group("unit_group", true)

func _physics_process(delta):
	velocity = global_position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()
	
func _input(event):
	if event.is_action_released("set_rally"):
		set_rally.rpc(event.position)
		
@rpc("any_peer", "call_local")
func set_rally(position):
	if is_multiplayer_authority():
		target = position
