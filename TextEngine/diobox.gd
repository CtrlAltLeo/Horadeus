extends Node


#array containing all the text. Set up when a new Diobox is made
var text = ["Dang, daniel.","I've already got a basic text engine","adding choices is next!"]
onready var textBox = $textBox
onready var textBoxText = $text

#which text line from text array is being used
var active = 0

#if all avalible text has been printed 
var endOfLine = false

var canSee = 0
onready var canSeeTimer = $canSeeTimer


func _ready():
	
	textBoxText.text = text[active]
	canSeeTimer.start()
	
	
	
	
# warning-ignore:unused_argument
func _process(delta):
	textBoxText.visible_characters = canSee
	
	if Input.is_action_just_pressed("leftMouse") and !endOfLine:
		canSee = text[active].length()
	if Input.is_action_just_pressed("leftMouse") and endOfLine:
		IsLastLine()
		
	
	if canSee >= text[active].length():
		endOfLine = true
	else:
		endOfLine = false
	
func IsLastLine():
	if active + 1 < text.size():
		nextPage()
	else:
		self.queue_free()

func nextPage():
	canSee = 0
	endOfLine = false
	active += 1
	textBoxText.text = text[active]
	canSeeTimer.start()

func _on_canSeeTimer_timeout():
	if !endOfLine:
		canSee += 1
		canSeeTimer.start()
		print(canSee)
