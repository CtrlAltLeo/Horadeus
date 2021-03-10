extends KinematicBody

onready var root = Globals.root

var type = "fire"

var dir = Vector3(0,0,1)

var y_velo = 15


func _ready():
	print(Globals.root.name)
	
	dir = dir * 5
	

func _physics_process(delta):
	
	
	dir.y = y_velo

	
	
	move_and_slide(dir,Vector3(0,1,0))

	if is_on_floor():
		dir = Vector3(0,0,0)
		y_velo = 0
		
		ThrowACrystal.CrystalEffects(self.transform, type)
		self.queue_free()
		

	if y_velo > -11:
		y_velo -= 1
		
	var distanceFromPlayer = root.get_node("player").translation - self.translation
	
#	if distanceFromPlayer.length() > Vector3(3,3,3).length():
#		dir = Vector3(0,0,0)
#		y_velo = 0
#
#
#
#	if is_on_floor():
#		dir = Vector3(0,0,0)


