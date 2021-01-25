extends Area2D


signal clicked
signal mouseEnter
signal mouseExit

var canClick = false

func _process(delta):
	if (canClick) and Input.is_action_just_pressed("leftMouse"):
		emit_signal("clicked")
	
	

func _on_clickableObject_mouse_entered():
	emit_signal("mouseEnter")
	canClick = true


func _on_clickableObject_mouse_exited():
	emit_signal("mouseExit")
	canClick = false
