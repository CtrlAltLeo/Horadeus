extends Spatial


var active_controller := false setget _set_active_controller
var pawn = null setget _set_pawn


func _ready():
	set_physics_process(active_controller)


# All code that controls the pawn belongs in here
func _physics_process(delta):
	pass


func _set_active_controller(active : bool):
	active_controller = active
	set_physics_process(active_controller and pawn != null)


func _set_pawn(new_pawn):
	pawn = new_pawn
	set_physics_process(active_controller and pawn != null)
