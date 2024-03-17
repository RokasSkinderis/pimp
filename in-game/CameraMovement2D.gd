extends Camera2D

# Speed of the camera movement
var speed = 1000
var zoom_speed = 0.1
var min_zoom = 0.5
var max_zoom = 2.0

func _process(delta):
	var movement = Vector2.ZERO # Initialize the movement vector

	# Check for input and adjust the movement vector accordingly
	if Input.is_action_pressed('camera_left'): # A or Left Arrow
		movement.x -= 1
	if Input.is_action_pressed('camera_right'): # D or Right Arrow
		movement.x += 1
	if Input.is_action_pressed('camera_up'): # W or Up Arrow
		movement.y -= 1
	if Input.is_action_pressed('camera_down'): # S or Down Arrow
		movement.y += 1

	# Normalize the movement vector to ensure consistent speed in all directions
	movement = movement.normalized() * speed

	# Apply the movement to the camera
	position += movement * delta

	# Zoom in or out with the mouse wheel
	if Input.is_action_just_pressed('camera_zoom_in'):
		zoom.x -= zoom_speed
		zoom.y -= zoom_speed
	elif Input.is_action_just_pressed('camera_zoom_out'):
		zoom.x += zoom_speed
		zoom.y += zoom_speed

	# Clamp the zoom level to prevent it from going below min_zoom or above max_zoom
	zoom.x = clamp(zoom.x, min_zoom, max_zoom)
	zoom.y = clamp(zoom.y, min_zoom, max_zoom)
