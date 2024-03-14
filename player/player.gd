extends CharacterBody2D


const SPEED = 300.0

func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

#func _physics_process(delta):
	#if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		#var direction = Input.get_axis("ui_left", "ui_right")
		#if direction:
			#velocity.x = direction * SPEED
		#else:
			#velocity.x = move_toward(velocity.x, 0, SPEED)
		#move_and_slide()

