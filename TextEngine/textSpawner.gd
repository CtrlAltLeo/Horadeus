extends Node2D


signal endBox(active, id)
signal nextPage(active, id)


var newBox = load("res://TextEngine/diobox.tscn")




func addNew(id,textArray:Array = ["OI! No text"],choices:Array = [],ends:Array = [],rSprite:String = "",lSprite:String = ""):
	var box = newBox.instance()
	box.text = textArray
	box.ends = ends
	box.choices = choices
	box.rSpriteTex = rSprite
	box.lSpriteTex = lSprite
	box.myId = id
	box.connect("endBox",self,"endOfABox")
	box.connect("nextPage",self,"endOfAPage")
	
	self.add_child(box)
	
func endOfABox(active, id):
	emit_signal("endBox",active, id)
	print(id," End of box")
	
	
func endOfAPage(active, id):
	emit_signal("nextPage", active, id)
	print(id," End of Page")
