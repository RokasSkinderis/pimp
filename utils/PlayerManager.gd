extends Node2D

@export var playerScene: PackedScene

func _ready():
	var playerIndex = 0
	for player in GameManager.players:
		var currentPlayer = playerScene.instantiate()
		currentPlayer.name = str(GameManager.players[player].id)
		initialize_player_unit_object(player)
		initialize_player_resource_object(player)
		intialize_player_spawn_locations(player, playerIndex, currentPlayer)
		add_child(currentPlayer)
		playerIndex += 1

func initialize_player_unit_object(player):
	GameManager.players[player].units = {
		"current": 0,
		"max": 10
	}
	
func initialize_player_resource_object(player):
	GameManager.players[player].resources = {
		"exp": 0,
		"expStep": 1,
		"gold": 10
	}
	
func intialize_player_spawn_locations(player, playerIndex, currentPlayerInstance):
	for spawn in get_tree().get_nodes_in_group("player_spawn_location"):
			if spawn.name == str(playerIndex):
				GameManager.players[player].spawnLocation = spawn.global_position
				currentPlayerInstance.global_position = spawn.global_position
