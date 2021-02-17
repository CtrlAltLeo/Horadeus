extends Node2D


signal endBox(active)
signal nextPage(active)


var newBox = load("res://TextEngine/diobox.tscn")




func addNew(textArray:Array = ["OI! No text"],choices:Array = [],ends:Array = [],rSprite:String = "",lSprite:String = ""):
	var box = newBox.instance()
	box.text = textArray
	box.ends = ends
	box.choices = choices
	box.rSpriteTex = rSprite
	box.lSpriteTex = lSprite
	
	box.connect("endBox",self,"endOfABox")
	box.connect("nextPage",self,"endOfAPage")
	
	self.add_child(box)
	
func endOfABox(active):
	emit_signal("endBox",active)
	print(active)
	
	
func endOfAPage(active):
	emit_signal("nextPage", active)
	print(active)
