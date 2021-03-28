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
	$textSpawner.addNew(0,["Testing, one two!", "Does it work?", "Awesome!", "Yep, it does!"], ["1:2:Sure does!:I hope so!:2:3"], [2, 3])



	


func _on_textSpawner_nextPage(active, id):
	pass


func _on_textSpawner_endBox(id):
	if id == 0:
		Globals.playerInventory.clearInventorySlot(1)
		
