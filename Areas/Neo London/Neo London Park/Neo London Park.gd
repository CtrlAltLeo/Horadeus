extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NPCONE_Interact_clicked():
	$textSpawner.addNew(0, ["Daaaaang this is a great demo", "Isn't Leo the best programmer ever?"])



	


func _on_textSpawner_nextPage(active, id):
	pass


func _on_textSpawner_endBox(id):
	if id == 0:
		Globals.playerInventory.addInventoryItem(Globals.allItems["crystals"]["fire"])
		
