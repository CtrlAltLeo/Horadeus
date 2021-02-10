extends Node2D

var newBox = load("res://TextEngine/Dialouge Maker Tool/TextLineNode.tscn")

var id = 0

onready var root = get_tree().get_current_scene()

onready var myText = $TextEdit.text

func _ready():
	root.textOutput.append("")


func _on_addText_pressed():
	var b = newBox.instance()
	
	b.position.x += 200 #root.totalTexts * 200
	
	
	b.id = root.totalTexts
	
	root.totalTexts += 1
	
	self.add_child(b)
	
	
	$TextEdit/addText.disabled = true


func _on_TextEdit_text_changed():
	root.textOutput[id] = '"'+ str($TextEdit.text) + '"'

func resetButton():
	$TextEdit/addText.disabled = false

func _on_Button_pressed():
	get_parent().resetButton()
	root.textOutput.remove(id)
	root.totalTexts -= 1
	self.queue_free()
