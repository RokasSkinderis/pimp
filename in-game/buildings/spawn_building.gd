extends StaticBody2D

@onready var spawn_timer: Timer = $Timer
@onready var unit = preload("res://in-game/units/unit.tscn")

func _enter_tree():
	set_multiplayer_authority(get_multiplayer_authority())
	
func _ready():
	$Authority.text = str(self.get_multiplayer_authority())
	spawn_timer.wait_time = 1
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()

func _on_spawn_timer_timeout():
	if GameManager.players[str(get_multiplayer_authority())].units.current < GameManager.players[str(get_multiplayer_authority())].units.max:
		spawn_unit()
	else:
		spawn_timer.stop()

func spawn_unit():
	var randomPositionX = randi_range(-50, 50)
	var randomPositionY = randi_range(-50, 50)
	
	var unit_spawn_position = position + Vector2(randomPositionX, randomPositionY)
	var new_unit = unit.instantiate()
	new_unit.position = unit_spawn_position
	GameManager.players[str(get_multiplayer_authority())].units.current += 1
	get_node("../UnitsGroup").add_child(new_unit, true)
