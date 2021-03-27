extends Spatial


func _process(_delta):
	_set_animation_direction()


# Returns which side of the PixelEntity is currently facing the active camera
func side_facing_camera():
	var current_camera = get_viewport().get_camera()
	if current_camera ==  null:
		print("No 3D camera found in PixelEntity.gd::side_facing_camera()")
		return "front"
	
	var camera_to_entity = translation - current_camera.global_transform.origin
	var radians_between_camera_and_entity = camera_to_entity.angle_to(get_facing_vector())
	
	if radians_between_camera_and_entity >= 2.356194:
		return "front"
	elif radians_between_camera_and_entity <= 0.785398:
		return "back"
	else:
		return "right" if camera_to_entity.x < 0.0 else "left"


# Returns the entitys current facing vector
func get_facing_vector():
	return Vector3.FORWARD.rotated(Vector3.UP, rotation_degrees.y)


# Sets the direction of the current animation
func _set_animation_direction():
	var current_animation = $AnimationPlayer.current_animation
	var facing = side_facing_camera()
	var new_animation = facing + current_animation.substr(current_animation.find("_"))
	
	if current_animation != new_animation:
		$Sprite3D.flip_h = (facing == "right")
		var current_time = $AnimationPlayer.current_animation_position
		$AnimationPlayer.current_animation = new_animation
		$AnimationPlayer.advance(current_time) # Advance the new animation to the frame of the last animation
