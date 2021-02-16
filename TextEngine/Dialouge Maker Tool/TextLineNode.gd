extends Node2D

var newBox = load("res://TextEngine/Dialouge Maker Tool/TextLineNode.tscn")

var id = 0

onready var root = get_tree().get_current_scene()

onready var myText = $TextEdit.text

func _ready():
	root.textOutput.append("")
	
	
	$OptionButton.add_item("one choice",0)
	
	$OptionButton.add_item("Two Choices",1)
	
	$OptionButton.add_item("Three Choices",2)
	
	
	$OptionButton.add_item("delete choices",3)


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


func _on_OptionButton_item_selected(id):
	var newB = load("res://TextEngine/Dialouge Maker Tool/choiceInstance.tscn")
	
	if id != 3:
	
		for i in id:
			var b = newB.instance()
			
			b.position.x += 100
			b.position.y -= 200
			b.position.y += i * 50
			
			self.add_child(b)
			
		
		
		
