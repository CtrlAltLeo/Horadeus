extends KinematicBody

const GRAVITY = Vector3.DOWN*1.5
var gravity_mod := 1.0

var forward_vector := Vector3.ZERO setget set_forward_vector
var speed := 1.0


func _ready():
	_check_for_stray_controllers()
	_set_active_controller()


func _physics_process(_delta):
	move_and_slide((forward_vector * speed) + (GRAVITY*gravity_mod), Vector3.UP)


func set_forward_vector(new_forward : Vector3, look_down_forward := true):
	forward_vector = new_forward
	# Point the Pawn in the direction of the new forward_vector if it is not zero
	new_forward = (new_forward*Vector3(1.0,0.0,1.0)).normalized()
	if look_down_forward and new_forward.length_squared() > 0.0:
		rotation_degrees = Vector3(0.0, (-1.0 if new_forward.x >= 0.0 else 1.0) * rad2deg(Vector3.FORWARD.angle_to(new_forward)), 0.0)


# Checks to see if there are any controllers outside of the $Pawn/Controllers and puts them where they belong
func _check_for_stray_controllers():
	# TODO: will need to change this to iterate in reverse at some point so order of stray controllers is retained
	for child in get_children():
		if child.has_method("_set_pawn"):
			remove_child(child)
			$Controllers.add_child(child)
			$Controllers.move_child(child, 0)


func _set_active_controller():
	var child_count = get_child_count()
	# If we have at least one controller...
	if child_count > 0:
		# Make first one the active controller
		var controller = get_child(0)
		controller.active_controller = true
		controller.pawn = get_parent()
		# And disable the rest
		for i in range(1,child_count):
			get_child(i).active_controller = false
