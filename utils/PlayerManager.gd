extends Node2D

@export var playerScene: PackedScene

func _ready():
	var playerIndex = 0
	for player in GameManager.players:
		var currentPlayer = playerScene.instantiate()
		currentPlayer.name = str(GameManager.players[player].id)
		GameManager.players[player].units = {
			"current": 0,
			"max": 10
		}
		
		for spawn in get_tree().get_nodes_in_group("player_spawn_location"):
			if spawn.name == str(playerIndex):
				GameManager.players[player].spawnLocation = spawn.global_position
				currentPlayer.global_position = spawn.global_position
		add_child(currentPlayer)
		playerIndex += 1
