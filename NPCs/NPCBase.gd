extends AnimatedSprite3D

onready var TargetPos = get_parent().get_child(1).translation

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
	
	
		
func _process(delta):
	TargetPos = get_parent().get_child(1).translation
	
	
	if TargetPos.z < self.translation.z -buffer and (TargetPos.x > self.translation.x):
		
		animation = "frontQuarterRight"
		flip_h = false
		
	if TargetPos.z < self.translation.z -buffer and (TargetPos.x < self.translation.x):
		print("oopsies")
		animation = "frontQuarterLeft"
		flip_h = false
		
	if TargetPos.z > self.translation.z  and (TargetPos.x > translation.x - 5 and TargetPos.x < translation.x + 5 ):
		
		animation = "back"
		flip_h = false
		
	if TargetPos.x > translation.x and (TargetPos.z > translation.z - buffer and TargetPos.z < translation.z + buffer) :
		print("Side")
		animation = "side"
		flip_h = false
		
		
	if TargetPos.x < translation.x and (TargetPos.z > self.translation.z - buffer and TargetPos.z < self.translation.z + buffer ):
		print("Side")
		animation = "side"
		flip_h = true	
		
