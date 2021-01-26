extends Node2D


signal clicked

var id = 0
var text = "choice"
var des = 0

func _ready():
	$choiceText.text = text
	
