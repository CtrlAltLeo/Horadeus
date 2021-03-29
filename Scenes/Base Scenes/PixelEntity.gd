extends Spatial

enum Mode {HARD, Y_BILLBOARD, EASE}

var mode = Mode.EASE

onready var sprite = $Sprite3D
onready var animation_player = $AnimationPlayer


func _ready():
	$DeleteMe/CanvasLayer/Label.text = "Hard Snap With Easing"


func _process(_delta):
	_set_animation_direction()
	_set_billboard_direction()
	$DeleteMe/CameraDolly.rotate(Vector3.UP, _delta*PI/15.0)


# Returns which side of the PixelEntity is currently facing the active camera
func side_facing_camera():
	var current_camera = get_viewport().get_camera()
	if current_camera ==  null:
		print("No 3D camera found in PixelEntity.gd::side_facing_camera()")
		return "front"
	
	var camera_to_entity = translation - current_camera.global_transform.origin
	var radians_between_camera_and_entity = Vector3(camera_to_entity.x, 0.0, camera_to_entity.z).angle_to(get_facing_vector())
	
	if radians_between_camera_and_entity > 2.356194:
		return "front"
	elif radians_between_camera_and_entity < 0.785398:
		return "back"
	else:
		return "right" if camera_to_entity.x < 0.0 else "left"


# Returns the entitys current facing vector
func get_facing_vector():
	return Vector3.FORWARD.rotated(Vector3.UP, rotation_degrees.y)


# Sets the direction of the current animation
func _set_animation_direction():
	var current_animation = animation_player.current_animation
	var facing = side_facing_camera()
	var new_animation = facing + current_animation.substr(current_animation.find("_"))
	
	if current_animation != new_animation:
		sprite.flip_h = (facing == "right")
		var current_time = animation_player.current_animation_position
		animation_player.current_animation = new_animation
		animation_player.advance(current_time) # Advance the new animation to the frame of the last animation


# Sets the rotation of the sprites Y axis so that faces the camera
func _set_billboard_direction():
	_check_for_new_mode()
	match mode:
		Mode.HARD:
			_hard_turn()
		Mode.Y_BILLBOARD:
			_y_billboarding()
		Mode.EASE:
			_ease_into_it()


func _check_for_new_mode():
	if Input.is_key_pressed(KEY_1):
		mode = Mode.Y_BILLBOARD
		$DeleteMe/CanvasLayer/Label.text = "Y Billboard"
	elif Input.is_key_pressed(KEY_2):
		mode = Mode.HARD
		$DeleteMe/CanvasLayer/Label.text = "Hard Snap"
	elif Input.is_key_pressed(KEY_3):
		mode = Mode.EASE
		$DeleteMe/CanvasLayer/Label.text = "Hard Snap With Easing"


func _y_billboarding():
	var current_camera = get_viewport().get_camera()
	sprite.look_at(current_camera.global_transform.origin, Vector3.UP)
	sprite.rotation_degrees = Vector3(0.0, sprite.rotation_degrees.y, 0.0)


func _hard_turn():
	match side_facing_camera():
		"front_right":	sprite.rotation_degrees = Vector3(0.0, 0.0, 0.0)
		"front_left":	sprite.rotation_degrees = Vector3(0.0, 0.0, 0.0)
		"front":		sprite.rotation_degrees = Vector3(0.0, 0.0, 0.0)
		"back":			sprite.rotation_degrees = Vector3(0.0, 180.0, 0.0)
		"left":			sprite.rotation_degrees = Vector3(0.0, -90.0, 0.0)
		"right":		sprite.rotation_degrees = Vector3(0.0, 90.0, 0.0)


func _ease_into_it():
	var current_camera = get_viewport().get_camera()
	if current_camera ==  null:
		print("No 3D camera found in PixelEntity.gd::side_facing_camera()")
		return 
	
	var camera_to_entity = translation - current_camera.global_transform.origin
	var degrees = rad2deg(Vector3(camera_to_entity.x, 0.0, camera_to_entity.z).angle_to(get_facing_vector()))
	
	# Now that's a one-liner
	degrees = ((degrees+(90.0*floor((degrees+45.0)/90.0)))/2.0) * (-1.0 if camera_to_entity.x >= 0.0 else 1.0)
	
	# What that one-liner use to look like
	# Keeping in case the one-liner ever needs to be dissected lol
	#if degrees <= 45: # Back
	#	degrees = (degrees)/2.0
	#elif degrees > 45.0 and degrees < 135.0: # Right/Left
	#	degrees = (degrees+90.0)/2.0
	#elif degrees >= 135.0: # Front
	#	degrees = (degrees+180.0)/2.0
	#degrees *= -1.0 if camera_to_entity.x >= 0.0 else 1.0
	
	sprite.rotation_degrees = Vector3(0.0, degrees, 0.0)
