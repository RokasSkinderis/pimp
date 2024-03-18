extends Control

@export var address = "127.0.0.1"
@export var port = 8910
@export var playerScene: PackedScene
var players_loaded = 0

var peer

func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	if "--server" in OS.get_cmdline_args():
		host_game()
	pass

func _process(delta):
	pass
	
func peer_connected(id):
	print("Player connected " + str(id))

func peer_disconnected(id):
	GameManager.players[str(id)].erase()
	var players = get_tree().get_nodes_in_group("player_group")
	for player in players:
		if player.name == str(id):
			player.queue_free()
	print("Player disconnected " + str(id))

func connected_to_server():
	print("Player connected to server")
#replace JOIN string with $NameInput.text
	send_player_info.rpc_id(1, 'JOIN', multiplayer.get_unique_id())

func connection_failed():
	print("Player connection failed")

@rpc("any_peer")
func send_player_info(name, id):
	if !GameManager.players.has(id):
		GameManager.players[str(id)] = {
			"name": name,
			"id": id
		}

	if multiplayer.is_server():
		for i in GameManager.players:
			send_player_info.rpc(GameManager.players[i].name, i)

@rpc("any_peer", "call_local")
func start_game():
	var gameScene = load("res://in-game/game.tscn").instantiate()
	# Check if all palyers are there
	if GameManager.players.size() == 2:
		get_tree().root.add_child(gameScene)
		self.hide()

	
	
func host_game():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 4)
	if error != OK:
		print("cannot host: " + str(error))
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for players to be ready")
	
func _on_host_button_down():
	host_game()
# replace HOST string with $NameInput.text
	send_player_info('HOST', multiplayer.get_unique_id())	
	
func join_game():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
func _on_join_button_down():
	join_game()

func _on_start_button_down():
	start_game.rpc()
	pass # Replace with function body.
