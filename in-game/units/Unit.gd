extends CharacterBody2D

@onready var target = position
var enemyUnitsInAttackArea = []

@export var damage = 5
@export var hitpoints = 50
var speed = 200

var attackerDamage = 0

func _enter_tree():
	set_multiplayer_authority(get_parent().get_multiplayer_authority())
	
func _ready():
	$HpBar.max_value = hitpoints
	add_to_group("unit_group", true)
	
func _process(delta):
	$HpBar.value = hitpoints
	if hitpoints <= 0:
		handle_death()

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

func handle_death():
	for player in GameManager.players:
		if player.to_int() != get_multiplayer_authority():
			GameManager.players[player].resources.exp += 1
	queue_free()
	
		
func start_attacking():
	$AttackTimer.start()


func _on_attack_timer_timeout():
	hitpoints -= 1 * attackerDamage

func _on_attack_area_entered(area):
	var units = area.get_overlapping_bodies()
	for unit in units:
		if "Unit" in unit.name:
			if get_multiplayer_authority() != unit.get_multiplayer_authority():
				if !enemyUnitsInAttackArea.has(unit):
					enemyUnitsInAttackArea.append(unit)
					attackerDamage = enemyUnitsInAttackArea.size() * unit.damage
					print(attackerDamage)
					
	start_attacking()


func _on_attack_area_exited(area):
	enemyUnitsInAttackArea = []
	var units = area.get_overlapping_bodies()
	for unit in units:
		if get_multiplayer_authority() != unit.get_multiplayer_authority():
				if !enemyUnitsInAttackArea.has(unit):
					enemyUnitsInAttackArea.append(unit)
					attackerDamage = enemyUnitsInAttackArea.size() * unit.damage
					print(attackerDamage)
	if enemyUnitsInAttackArea.size() == 0:
		$AttackTimer.stop()
