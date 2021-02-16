extends KinematicBody

var mouseSense = 1.2

onready var camRoot = $cameraRoot
onready var sprite = $sprite
onready var cam = $cameraRoot/Camera

var y_velo = 0

var speed = 10

const Gravity = 40



func _ready():
	pass
	
	


func _input(event):
	
	if event is InputEventMouseMotion:
		
		#@camRoot.rotation_degrees.y -= event.relative.x * mouseSense
		self.rotation_degrees.y -= event.relative.x * mouseSense
		
		if camRoot.rotation_degrees.y > 360:
			camRoot.rotation_degrees.y = 0
		
		if camRoot.rotation_degrees.y < 0:
			camRoot.rotation_degrees.y = 360
		
		if camRoot.rotation_degrees.x - event.relative.y > -75 and camRoot.rotation_degrees.x - event.relative.y < 10:
			camRoot.rotation_degrees.x -= event.relative.y * mouseSense
			
			
func _process(delta):
	
	#updateSprite()
	
	animate()
	
	pass
	
func _physics_process(delta):
	
	var movement = Vector3()
	
	movement.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	
	movement.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	movement = movement.rotated(Vector3(0,1,0),self.rotation.y)
#
#	movement.y = y_velo
#
#	y_velo = -10
	
	move_and_slide(movement * speed)
	
	
	
	
	
	
func animate():
	var forward = Input.is_action_pressed("forward")
	
	if forward:
		$sprite.playing = true
	else:
		$sprite.playing = false
	
	
	
	
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
		
	elif camRot < 180 and camRot > 120:
		sprite.animation = "front"
		sprite.flip_h = false
	
	elif camRot < 240 and camRot > 180:
		sprite.animation = "front"
		sprite.flip_h = true
		
	
		
		
	
	
	

