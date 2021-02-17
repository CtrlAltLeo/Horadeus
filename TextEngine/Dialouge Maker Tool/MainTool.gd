extends Control


var totalTexts = 0

var textOutput = []

var choicesOutput = []

var ends = []

var methodOutput = []

var newChoiceBox = load("res://TextEngine/Dialouge Maker Tool/TextLineNode.tscn")

func _input(event):
	
	if event is InputEventMouseMotion:
		
		if Input.is_action_pressed("leftMouse"):
			$scrollable.position.x += event.relative.x

func _on_newText_pressed():
	
	
	var b = newChoiceBox.instance()
	
	b.id = totalTexts
	
	
	$scrollable.add_child(b)
	
	totalTexts += 1
	
	$scrollable/newText.queue_free()


func _on_compile_pressed():
	methodOutput.clear()
	
	methodOutput.append(textOutput)
	methodOutput.append(choicesOutput)
	methodOutput.append(ends)
	
	print(methodOutput)

	

	
