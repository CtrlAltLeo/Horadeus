extends Node

#Nice globals, good Globals.....
onready var root = get_tree().current_scene

onready var playerInventory = root.get_node("player").get_node("Inventory")

var allItems = {
	
	"crystals":{
		"fire":["fire","res://UI/HUD/itemTextures/crystalTextures/sprite_0.png"],
		"ice":["ice","res://UI/HUD/itemTextures/crystalTextures/sprite_1.png"],
		"air":["air","res://UI/HUD/itemTextures/crystalTextures/sprite_2.png"]
		
		
		
	}
	
	
	
}


