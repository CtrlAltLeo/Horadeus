extends AnimatedSprite3D

onready var TargetPos = get_parent().get_child(0).translation

var NW = Vector3(-1,0,-1)

var NE = Vector3(1,0,-1)

var SW = Vector3(-1,0,1)

var SE = Vector3(1,0,1)

var buffer = 5

#0 is front, 1 is side, 2 is back
var NPC_Facing = 0

var formula = Vector3()

func _ready():
	
	
	print(TargetPos)
	
	if TargetPos.z < self.translation.z and (TargetPos.x > translation.x - 5 and TargetPos.x < translation.x + 5 ):
		print("Front")
	if TargetPos.z > self.translation.z:
		print("Back")
		
	if TargetPos.x > translation.x + buffer:
		print("side")
