extends Node

var myId = 0

signal endBox(active, id)
signal nextPage(active, id)


#array containing all the text. Set up when a new Diobox is made
var text = ["This is a text","And this is a choice!","You pressed choice one. Bye!","You pressed Choice 2. Bye!"]
onready var textBox = $textBox
onready var textBoxText = $text

#which text line from text array is being used
var active = 0

#if all avalible text has been printed 
var endOfLine = false

#how many characters a player can see. Makes the "scrolling text" effect 
var canSee = 0
onready var canSeeTimer = $canSeeTimer

#All lines of text that will terminate the box
#You'll need to put stuff here
var ends = [2,3]

#If active is a choice
var isAChoice = false

#DOn't put anything in this ARRAY!@!!
var choiceTriggers = []

#The actual Choice Text
#Choice Format When It Triggers:How Many there are:ChoiceText1-X:Corrisponding Choice Destination
var choices = ["0:2:no:yes:2:2"]

onready var leftSprite = $leftSprite
onready var rightSprite = $rightSprite

var lSpriteTex = ""
var rSpriteTex = ""


func _ready():
	
	initChoices()
	checkIfChoice()
	
	textBoxText.text = text[active]
	canSeeTimer.start()
	
	if lSpriteTex != "" and rSpriteTex != "":
		
		leftSprite.texture = load(lSpriteTex)
		rightSprite.texture = load(rSpriteTex)
	
	
	
	
# warning-ignore:unused_argument
func _process(delta):
	textBoxText.visible_characters = canSee
	
	if canSee >= text[active].length():
		endOfLine = true
	else:
		endOfLine = false
		

	
func IsLastLine():
	if active + 1 < text.size() and !checkActiveAgainstEnd():
		nextPage()
	else:
		emit_signal("endBox", active, myId)
		self.queue_free()

#loops through all the ends, and will return a True to isLastLine to terminate Text Box
func checkActiveAgainstEnd():
	if ends.size() != 0:
		for i in ends:
			if active == i:
				return true
			else:
				pass
		
	

func nextPage():
	
	emit_signal("nextPage",active, myId)
	
	canSee = 0
	endOfLine = false
	active += 1
	
	textBoxText.text = text[active]
	canSeeTimer.start()
	
	checkIfChoice()

func _on_canSeeTimer_timeout():
	if !endOfLine:
		canSee += 1
		canSeeTimer.start()
		#print(canSee)

#Determines MouseClick in Box
func _on_clickableObject_clicked():
	
	if !endOfLine:
		canSee = text[active].length()
	if endOfLine and !isAChoice:
		IsLastLine()
		
func initChoices():
	for i in choices:
		#print(i)
		var choiceStaging = i.split(":")
		#print(choiceStaging[0])
		choiceTriggers.append(choiceStaging[0])
		
func checkIfChoice():
	for i in choiceTriggers:
		if active == int(i):
			isAChoice = true
			setupChoiceBoxes()
			
func setupChoiceBoxes():
	var choiceBox = "res://TextEngine/choice.tscn"
	
	var staticRank = int(choiceTriggers.find(str(active)))
	#Split Choice Zero is when it's active
	#Split Choice One is the number of Choices in the Choice Datapack
	
	var splitChoice = choices[staticRank].split(":")
	var numberOfChoices = int(splitChoice[1])
	
	var choiceText = []
	var choiceDes = []
	
	for i in numberOfChoices:
		choiceText.append(splitChoice[2+i])
		
		choiceDes.append(splitChoice[ 2 + numberOfChoices + i ])
		
#	print(choiceText)	
#	print(choiceDes)
	
	for i in numberOfChoices:
		var nBox = load("res://TextEngine/choice.tscn").instance()
		nBox.text = choiceText[i]
		nBox.des = choiceDes[i]
		
		nBox.connect("clicked",self, "FlipToPage")
		
		if i < 3:
			nBox.position = Vector2(890, 440 + (i * 75))
		
		
		$Choices.add_child(nBox)
		
	
func FlipToPage(page):
	isAChoice = false
	canSee = 0
	endOfLine = false
	active = int(page)
	emit_signal("nextPage",active, myId)
	textBoxText.text = text[active]
	canSeeTimer.start()
	
	checkIfChoice()
	
	for i in $Choices.get_child_count():
		$Choices.get_child(i).queue_free()
		
	
	
	
	
	
	

