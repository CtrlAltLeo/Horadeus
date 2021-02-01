extends Node




func _input(event):
	
	if event is InputEventMouseMotion:
		
		$cameraRoot.rotation_degrees.y -= event.relative.x
		
		if $cameraRoot.rotation_degrees.x - event.relative.y > -75:
			$cameraRoot.rotation_degrees.x -= event.relative.y
