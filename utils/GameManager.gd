extends Node2D

@export var playerScene: PackedScene

func _ready():
	var playerIndex = 0
	var players
	if GameManager.players.is_empty():
		players = GameManager.testPlayers
	else:
		players = GameManager.players
	for player in players:
		var currentPlayer = playerScene.instantiate()
		currentPlayer.name = str(players[player].id)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("player_spawn_location"):
			if spawn.name == str(playerIndex):
				players[player].spawnLocation = spawn.global_position
				currentPlayer.global_position = spawn.global_position
		playerIndex += 1
	
