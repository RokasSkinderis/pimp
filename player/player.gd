extends Node2D


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	self.set_multiplayer_authority(self.name.to_int(), true)

func _ready():
	$PlayerName.text = GameManager.players[str(self.get_multiplayer_authority())].name
