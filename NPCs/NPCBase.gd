extends AnimatedSprite3D


var NW = Vector3(-1,0,-1)

var NE = Vector3(1,0,-1)

var SW = Vector3(-1,0,1)

var SE = Vector3(1,0,1)

#0 is front, 1 is side, 2 is back
var NPC_Facing = 0

func _ready():
	
	print(NW<NE)
