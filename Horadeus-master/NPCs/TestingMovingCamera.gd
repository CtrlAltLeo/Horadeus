extends Spatial

func _input(event):
	
	if event is InputEventMouseMotion:
		self.rotation_degrees.y -= event.relative.x



func _process(delta):
	
	
	if Input.is_key_pressed(KEY_W):
		self.translate(Vector3(0,0,-.1))
		
	
	if Input.is_key_pressed(KEY_S):
		self.translate(Vector3(0,0,.1))
		
	
	if Input.is_key_pressed(KEY_A):
		self.translate(Vector3(-.1,0,0))
		
	
	if Input.is_key_pressed(KEY_D):
		self.translate(Vector3(.1,0,0))
		
