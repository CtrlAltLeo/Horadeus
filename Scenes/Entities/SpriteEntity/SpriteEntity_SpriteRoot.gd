extends Spatial

enum BillboardMode {Y_Billboard_Ease, Y_Billboard, Snap, Snap_Ease, Negated_Y_Billboard}

export(int, "Y Billboard Ease", "Y Billboard", "Snap", "Snap Ease", "Negated Y Billboard") var billboard_mode := BillboardMode.Y_Billboard_Ease

onready var entity_root = get_parent()
onready var animation_player = entity_root.get_node("AnimationPlayer")

var _has_two_front_animations := false


func _ready():
	if get_viewport().get_camera() ==  null: print("No 3D camera found in SpriteEntity.gd::_ready(); The class will not behave properly without a camera.")
	
	# Determine if the animation has two front animations (frontleft and frontright)
	for animation in animation_player.get_animation_list():
		if animation.find("frontleft") != -1: 
			_has_two_front_animations = true
			break


func _process(_delta):
	# Done in process because it is a visual effect; no need to clog up the physics engine
	var degrees = _get_billboard_degrees()
	_set_animation_direction(side_facing_camera(degrees))
	rotation_degrees = Vector3(0.0, degrees, 0.0)


# Returns which side of the SpriteEntity is currently facing the active camera
func side_facing_camera(degrees : float) -> String:
	if degrees <= 45.0 and degrees >= -45.0:
		if _has_two_front_animations:
			return "frontright" if degrees > 0.0 else "frontleft"
		else:
			return "front"
	elif degrees < 135.0 and degrees >= 45.0:
		return "right"
	elif degrees > -135.0 and degrees <= -45.0:
		return "left"
	else:
		return "back"


# Returns the entitys current facing vector
func get_facing_vector() -> Vector3:
	return Vector3.FORWARD.rotated(Vector3.UP, deg2rad(entity_root.rotation_degrees.y))


# Sets the direction of the current animation
func _set_animation_direction(facing : String):
	var current_animation = animation_player.current_animation
	var new_animation = facing + current_animation.substr(current_animation.find("_"))
	
	if current_animation != new_animation and current_animation != "":
		var current_time = animation_player.current_animation_position
		animation_player.current_animation = new_animation
		animation_player.advance(current_time) # Advance the new animation to the frame of the last animation


# Returns the degree (based on billboard mode) that the Sprite3D should be facing the camera
func _get_billboard_degrees() -> float:
	var current_camera = get_viewport().get_camera()
	if current_camera ==  null:
		return 0.0
	
	# Get the camera position in local coordinates of the entity
	var camera_to_entity_local = entity_root.global_transform.basis.xform_inv(current_camera.global_transform.origin - entity_root.translation)
	var degrees = rad2deg(Vector2(camera_to_entity_local.x, camera_to_entity_local.z).angle_to(Vector2(0.0, -1.0)))
	
	if billboard_mode == BillboardMode.Y_Billboard_Ease:
		pass # TODO: add Y Billboard with Ease
	elif billboard_mode == BillboardMode.Snap:
		degrees = 90.0*floor((degrees+45.0)/90.0)
	elif billboard_mode == BillboardMode.Snap_Ease:
		degrees = ((degrees+(90.0*floor((degrees+45.0)/90.0)))/2.0)
	elif billboard_mode == BillboardMode.Negated_Y_Billboard:
		degrees *= -1.0
	
	return degrees
