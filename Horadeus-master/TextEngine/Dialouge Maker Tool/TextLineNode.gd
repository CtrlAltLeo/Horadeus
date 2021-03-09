extends Node2D

var newBox = load("res://TextEngine/Dialouge Maker Tool/TextLineNode.tscn")

var id = 0

var myChoice = []
var choiceText = []
var choiceDes = []

onready var root = get_tree().get_current_scene()

onready var myText = $TextEdit.text

func _ready():
	
	
	root.textOutput.append("")
	
	$OptionButton.add_item("delete choices",0)
	
	$OptionButton.add_item("one choice",1)
	
	$OptionButton.add_item("Two Choices",2)
	
	$OptionButton.add_item("Three Choices",3)
	
	
	


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
	
	for i in get_children():
			if i.is_in_group("choice"):
				remove_child(i)
				
	myChoice.clear()
	
	var newB = load("res://TextEngine/Dialouge Maker Tool/choiceInstance.tscn")
	
	if id != 0:
		
		myChoice.append(root.totalTexts-1)
		myChoice.append(id)
		

		for i in id:
			
			choiceText.append("")
			
			var b = newB.instance()

			b.id = i
			
			
			
			b.position.x += 200
			b.position.y = self.position.y
			b.position.y += i * 120

			self.add_child(b)
			
	if id == 0:
		for i in get_children():
			if i.is_in_group("choice"):
				remove_child(i)
			
	print(myChoice)
		
		
		


func _on_CheckBox_toggled(button_pressed):
	if button_pressed == true:
		root.ends.append(id)
	
	if button_pressed == false:
		root.ends.erase(id)
	


func _on_compileCHoice_pressed():
	var finishedChoice = []
	var finale = ""
	
	for i in myChoice:
		finishedChoice.append(i)

	for i in choiceText:
		finishedChoice.append(i)
		
	for i in choiceDes:
		finishedChoice.append(i)
	
	for i in finishedChoice.size():
		
		print(i)
		
		if i != finishedChoice.size()-1:
			finishedChoice[i] = str(finishedChoice[i]) + ":"
		
		else:
			finishedChoice[i] = (str(finishedChoice[i]) )

	for i in finishedChoice:
		finale = finale + str(i)
		
	finale = '"'+finale+'"'
	
	print(finale)
	
	root.choicesOutput.append(finale)
				
				
	
		
