extends Area

signal hit

#Types include Fire, Ice, Air, X
export var type = ""
export var hurtBy = ["fire"]
 

export var takeHits = false
export var giveHits = false


func _process(delta):
	pass




func _on_damangeEmitSense_area_entered(area):
	if takeHits == true:
		if area.giveHits == true:
			for i in hurtBy:
				if area.type == i:
					emit_signal("hit")
					print("That's a hit!")
				
		

func _on_damangeEmitSense_area_exited(area):
	pass # Replace with function body.


func _on_burningTimer_timeout():
	pass # Replace with function body.
