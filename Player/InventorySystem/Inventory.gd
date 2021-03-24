extends Node2D

var active = 0

var readyToAttack = true

var inventoryContents = []
var itemCount = ["","","","","","","",""]

var allItems = Globals.allItems

onready var boxObjects = $AllItems

func _ready():
	init_Boxes()
	
	addInventoryItem(allItems["crystals"]["ice"])
	
	

func _process(delta):
	
	
	
	if (readyToAttack):
		
		if Input.is_action_just_pressed("nextItem"):
			if active + 1 > 7:
				active = 0
			
			elif active + 1 <= 7:
				active += 1
			
				
		if Input.is_action_just_pressed("previousItem"):
			if active - 1 >= 0:
				active -= 1
			elif active -1 < 0:
				active = 7
				
		
		
		if Input.is_action_just_pressed("one"):
			active = 0
			
		if Input.is_action_just_pressed("two"):
			active = 1
			
		if Input.is_action_just_pressed("three"):
			active = 2
			
		highlightSelected()
		

func highlightSelected():
	
	for i in boxObjects.get_child_count():
		if i == active:
		
			boxObjects.get_child(i).scale = Vector2(11,11)
			
		if i != active:
			
			boxObjects.get_child(i).scale = Vector2(10,10)

func updateItemCount():
	pass

func readyInventory():
	$AnimationPlayer.play_backwards("shrink")
	readyToAttack = true
	
func hideInventory():
	$AnimationPlayer.play("shrink")
	readyToAttack = false

#allItems["fire"]
func addInventoryItem(object):
	
	var nextItem = inventoryContents.size()
	
	
	if nextItem < 7:

		boxObjects.get_child(nextItem).get_child(0).texture = load(object[1])
		inventoryContents.append(object[0])
		print(inventoryContents[nextItem ])

	
func ClearInventorySlot(slot):
	boxObjects.get_child(slot - 1).get_child(0).texture = null
	
	
	
func emptyInventory():
	for i in boxObjects.get_child_count():
		boxObjects.get_child(i).get_child(0).texture = null
		
func init_Boxes():
	for i in 8:
		boxObjects.get_child(i).position.x = 150 + (100*i)
		boxObjects.get_child(i).position.y = 515
		
