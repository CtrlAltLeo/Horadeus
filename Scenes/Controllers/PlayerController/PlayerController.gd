extends "res://Scenes/Controllers/BaseController/BaseController.gd"

onready var camera_dolly = $CameraDolly
onready var camera = $CameraDolly/Camera

var _turn_speed := 2.5


func _process(delta):
	if Input.is_action_pressed("scroll"):
		print("scroll")


func _physics_process(delta):
	var local_forward = _compute_local_forward_vector()
	
	# Check X axis (Is player turning?)
	if local_forward.x != 0.0:
		pawn.rotate(Vector3.UP, -local_forward.x * delta * _turn_speed)
		local_forward = (local_forward * Vector3(0.0, 1.0, 1.0)).normalized() # Remove X from forward
		
	pawn.set_forward_vector(local_forward.rotated(Vector3.UP, deg2rad(pawn.rotation_degrees.y)), local_forward.z <= 0)


# Returns the forward vector of the player controler in it's local coordinates
func _compute_local_forward_vector() -> Vector3:
	var forward = Vector3.ZERO
	forward.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	forward.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	return forward.normalized()
