extends Node

onready var camRoot = $cameraRoot
onready var sprite = $sprite
onready var cam = $cameraRoot/Camera



func _ready():
	
	$textSpawner.addNew(["Zed","One","Two","Three"])


func _input(event):
	
	if event is InputEventMouseMotion:
		
		camRoot.rotation_degrees.y -= event.relative.x
		
		if camRoot.rotation_degrees.y > 360:
			camRoot.rotation_degrees.y = 0
		
		if camRoot.rotation_degrees.y < 0:
			camRoot.rotation_degrees.y = 360
		
		if camRoot.rotation_degrees.x - event.relative.y > -75 and camRoot.rotation_degrees.x - event.relative.y < 10:
			camRoot.rotation_degrees.x -= event.relative.y
			
			
func _process(delta):
	
	updateSprite()
	
	print(camRoot.rotation_degrees.y)
	
	
func _physics_process(delta):
	
	pass
	
	
	
	
func updateSprite():
	
	var camRot = camRoot.rotation_degrees.y
	
	if camRot < 50 or camRot > 310:
		sprite.animation = "back"
		
	elif camRot > 50 and camRot < 120:
		sprite.animation = "side"
		sprite.flip_h = false
	
	elif camRot > 240 and camRot < 310:
		sprite.animation = "side"
		sprite.flip_h = true
		
	elif camRot < 240 and camRot > 120:
		sprite.animation = "front"
	
		
		
	
	
	

