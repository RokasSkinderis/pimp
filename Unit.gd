extends CharacterBody2D

@onready var target = position
var speed = 300

func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	add_to_group("unit_group", true)
	#add_unit_path()


func _physics_process(delta):
	#if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 5:
		move_and_slide()
	
func _input(event):
	if event.is_action_released("set_rally"):
		target = get_viewport().get_mouse_position()
	
#func add_unit_path():
	#if $MultiplayerSynchronizer.get_multiplayer_authority() != multiplayer.get_unique_id():
		#target = GameManager.players[multiplayer.get_unique_id()].spawnLocation
		#print(target)
