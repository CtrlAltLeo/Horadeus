extends KinematicBody

onready var root = Globals.root


var dir = Vector3(0,0,1)

var y_velo = 10


func _ready():
	print(Globals.root.name)

func _physics_process(delta):
	
	dir = dir * 5
	
	dir.y = y_velo

	
	
	move_and_slide(dir,Vector3(0,1,0))

	y_velo -= 1
		
	var distanceFromPlayer = root.get_node("player").translation - self.translation
	
	if distanceFromPlayer.length() > Vector3(3,3,3).length():
		dir = Vector3(0,0,0)
		y_velo = 0
	
		
#
#	if is_on_floor():
#		dir = Vector3(0,0,0)
	
	
