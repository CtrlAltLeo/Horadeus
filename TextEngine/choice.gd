extends Node2D


signal clicked

var id = 0
var text = "choice"

func _ready():
	$choiceText.text = text
	
