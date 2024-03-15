extends StaticBody2D

@onready var spawn_timer: Timer = $Timer
@onready var unit = preload("res://in-game/units/unit.tscn")
@onready var authorityId
	
func _ready():
	#print('AuthorityId ', self.get_multiplayer_authority(), 'Multi ID ', multiplayer.get_unique_id())
	#authorityId = self.get_multiplayer_authority()
	#if 	is_multiplayer_authority():
		
		spawn_timer.wait_time = 1
		spawn_timer.timeout.connect(_on_spawn_timer_timeout)
		spawn_timer.start()

func _on_spawn_timer_timeout():
	if GameManager.players[str(multiplayer.get_unique_id())].units.current < GameManager.players[str(multiplayer.get_unique_id())].units.max:
		spawn_unit()
	else:
		spawn_timer.stop()

func spawn_unit():
	var randomPositionX = randi_range(-50, 50)
	var randomPositionY = randi_range(-50, 50)
	
	var unit_spawn_position = position + Vector2(randomPositionX, randomPositionY)
	var new_unit = unit.instantiate()
	new_unit.position = unit_spawn_position
	new_unit.set_multiplayer_authority(multiplayer.get_unique_id())
	GameManager.players[str(multiplayer.get_unique_id())].units.current += 1
	get_node("../UnitsGroup").add_child(new_unit, true)
