extends AnimatedSprite3D


onready var TargetPos = get_parent().get_node("player").translation


export var facing = Vector3(0,0,-1)

var buffer = 5

var vectorToPlayer = Vector3()

#0 is front, 1 is side, 2 is back
var NPC_Facing = 0

var formula = Vector3()

export var OnlyFront = false

func _ready():
	
	pass
	
	
		
func _process(delta):
	TargetPos = get_parent().get_node("player").translation

	playerVectorCompare()	

	if not OnlyFront:
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
			
#	if OnlyFront:
#		self.animation = "front"

func playerVectorCompare():
	vectorToPlayer = TargetPos - self.translation
	
	vectorToPlayer = vectorToPlayer.normalized()
	
	#print(vectorToPlayer.normalized().dot(facing.normalized()))
	
	if vectorToPlayer.dot(facing) > 0:
		#print("Font")
		self.animation = "front"
	else:
		self.animation = "back"
		#print("back")		
