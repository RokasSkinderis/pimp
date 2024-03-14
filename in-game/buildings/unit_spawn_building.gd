extends StaticBody2D

@onready var spawn_timer: Timer = $Timer
@onready var unit = preload("res://in-game/units/unit.tscn")

func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	#GameManager.players[multiplayer.get_unique_id()]
	spawn_timer.wait_time = 3
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()

	

func _on_spawn_timer_timeout():
	if GlobalGameResources.population.current < GlobalGameResources.population.max:
		spawn_unit()
	else:
		spawn_timer.stop()

func spawn_unit():
	var randomPositionX = randi_range(-50, 50)
	var randomPositionY = randi_range(-50, 50)
	
	var unit_spawn_position = position + Vector2(randomPositionX, randomPositionY)
	var new_unit = unit.instantiate()
	
	new_unit.position = unit_spawn_position
	GlobalGameResources.population.current += 1

	$UnitGroup.add_child(new_unit, true)
