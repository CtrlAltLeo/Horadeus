extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$textSpawner.addNew(["This NPC interaction was lovingly created with the Leo Approved Text Helper!", "Two Damn long", "I cna't even spell anymore", "Yep."], ["0:2:How long did it take?:Are you proud of yourself?:1:3"], [2, 3])
