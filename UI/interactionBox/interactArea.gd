extends Area

signal clicked

#If hte player is in the area, then you can click to interact
var canClick = false

func _process(delta):
	if canClick:
		$Control/AnimatedSprite.show()
	else:
		$Control/AnimatedSprite.hide()
		
	if Input.is_action_just_pressed("leftMouse"):
		if canClick:
			canClick = false
			emit_signal("clicked")
			

func _on_interactArea_body_entered(body):
	#checks to see if it's the Player
	if body.is_in_group("player"):
		canClick = true
		


func _on_interactArea_body_exited(body):
	if body.is_in_group("player"):
		canClick = false
