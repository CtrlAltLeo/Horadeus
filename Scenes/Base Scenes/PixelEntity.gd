extends Spatial

onready var sprite = $Sprite3D
onready var animation_player = $AnimationPlayer


func _process(_delta):
	_set_animation_direction()
	_set_billboard()


# Returns which side of the PixelEntity is currently facing the active camera
func side_facing_camera() -> String:
	var current_camera = get_viewport().get_camera()
	if current_camera ==  null:
		print("No 3D camera found in PixelEntity.gd::side_facing_camera()")
		return "frontright"
	
	var camera_to_entity = translation - current_camera.global_transform.origin
	var radians_between_camera_and_entity = Vector3(camera_to_entity.x, 0.0, camera_to_entity.z).angle_to(get_facing_vector())
	
	if radians_between_camera_and_entity > PI*0.75:
		return "front" + ("left" if camera_to_entity.x >= 0.0 else "right")
	elif radians_between_camera_and_entity < PI*0.25:
		return "back"
	elif camera_to_entity.x < 0.0:
		return "right"
	else:
		return "left"


# Returns the entitys current facing vector
func get_facing_vector() -> Vector3:
	return Vector3.FORWARD.rotated(Vector3.UP, rotation_degrees.y)


# Sets the direction of the current animation
func _set_animation_direction():
	var current_animation = animation_player.current_animation
	var facing = side_facing_camera()
	var new_animation = facing + current_animation.substr(current_animation.find("_"))
	
	if current_animation != new_animation:
		var current_time = animation_player.current_animation_position
		animation_player.current_animation = new_animation
		animation_player.advance(current_time) # Advance the new animation to the frame of the last animation


# Sets the rotation of the sprites Y axis so that faces the camera
func _set_billboard():
	var current_camera = get_viewport().get_camera()
	if current_camera ==  null:
		print("No 3D camera found in PixelEntity.gd::_set_billboard()")
		return 
	
	var camera_to_entity = translation - current_camera.global_transform.origin
	var degrees = rad2deg(Vector3(camera_to_entity.x, 0.0, camera_to_entity.z).angle_to(get_facing_vector()))
	
	# Now that's a one-liner; commit 6ee67a271b2068e85f13ee6c17f7487bec5a08b5 on sprite_overhaul branch has full code if needed
	degrees = ((degrees+(90.0*floor((degrees+45.0)/90.0)))/2.0) * (-1.0 if camera_to_entity.x >= 0.0 else 1.0)
	sprite.rotation_degrees = Vector3(0.0, degrees, 0.0)
