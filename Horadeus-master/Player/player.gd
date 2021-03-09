extends KinematicBody

var mouseSense = 1.2

onready var camRoot = $cameraRoot
onready var sprite = $sprite
onready var cam = $cameraRoot/Camera

var y_velo = 0

var topSpeed = 20
var startSpeed = 1
var speedLevel = 1.05

var speed = 1


const Gravity = 40



func _ready():
	pass
	
	


func _input(event):
	
	if event is InputEventMouseMotion:
		
		#@camRoot.rotation_degrees.y -= event.relative.x * mouseSense
		#this rotates teh player, not the camera y
		self.rotation_degrees.y -= event.relative.x * mouseSense
		
		
		#This code will keep the rotation degreese within 360
		if camRoot.rotation_degrees.y > 360:
			camRoot.rotation_degrees.y = 0
		if camRoot.rotation_degrees.y < 0:
			camRoot.rotation_degrees.y = 360

		#this will make sure you can't go over the player with your camera, and remain behind		
		if camRoot.rotation_degrees.x - event.relative.y > -70 and camRoot.rotation_degrees.x - event.relative.y < 10:
			camRoot.rotation_degrees.x -= event.relative.y * mouseSense
			
			
func _process(delta):
	
	if Input.is_action_just_pressed("leftMouse"):
		ThrowACrystal.throwCrystal()
	
	#updateSprite()
	
	animate()
	
	pass
	
func _physics_process(delta):
	
	var movement = Vector3()
	
	movement.z = Input.get_action_strength("forward") - Input.get_action_strength("back")
	
	movement.x = Input.get_action_strength("left") - Input.get_action_strength("right")
	
	if movement.z == 0 and movement.x == 0:
		speed = 1
		
	
	
	movement = movement.rotated(Vector3(0,1,0),self.rotation.y)

	movement = movement * speed
	
	if speed < topSpeed:
		speed = speed * speedLevel
	

	movement.y = y_velo

	
	move_and_slide(movement,Vector3(0,1,0))
	
	
	
	y_velo -= Gravity
	
	if y_velo < -30:
		y_velo = -30
	
	if is_on_floor():
		y_velo = -1
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		y_velo = 200
		
		
	
	
	
	
	
	
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
		
	
		
		
	
	
	

