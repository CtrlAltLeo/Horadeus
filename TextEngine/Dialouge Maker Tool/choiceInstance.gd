extends Node2D

var newTextbox = load("res://TextEngine/Dialouge Maker Tool/TextLineNode.tscn")

var id = 0

onready var root = get_tree().get_current_scene()

func _ready():
	print(id)
	
	
	
	
func addNewTextBox():
	var b = newTextbox.instance()
	
	b.position.x += 200 #root.totalTexts * 200
	
	
	b.id = root.totalTexts
	
	
	get_parent().choiceDes.append(root.totalTexts)
	
	root.totalTexts += 1
	
	self.add_child(b)
	
	print(get_parent().choiceDes)


#use a function to first constructg the choices, then string each text line


func _on_add_text_pressed():
	addNewTextBox()


func _on_TextEdit_text_changed():
	get_parent().choiceText[id] = $TextEdit.text
