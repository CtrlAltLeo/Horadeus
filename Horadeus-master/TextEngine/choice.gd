extends Node2D


signal clicked(des)

var id = 0
var text = "choice"
var des = 0

func _ready():
	$choiceText.text = text
	


func _on_clickableObject_clicked():
	emit_signal("clicked", des)
