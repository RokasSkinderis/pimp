extends Control

@onready var player = GameManager.players[str(multiplayer.get_unique_id())]

func _process(delta):
	$PopulationBox.text = "Pop " + str(player.units.current) + "/" + str(player.units.max)
	$XpBar.value = player.resources.exp
