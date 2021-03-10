extends Spatial


var newC = load("res://Player/CrystalThrowing/Thrown Crystal.tscn")

var chris ={
	
		"fire": load("res://Player/CrystalThrowing/TypesOfCrystals/fireCrystalMokup.tscn")

}
onready var root = get_tree().current_scene

func _process(delta):
	pass
	
	
func throwCrystal(type):
	
	
	
	var n = newC.instance()
	
	print(get_tree().current_scene.name)
	
	n.type = type
	
	n.translation = root.get_node("player").translation
	n.rotation = root.get_node("player").rotation
#	n.dir =  root.get_node("player/Target").translation - root.get_node("player").translation

	n.dir = n.dir.rotated(Vector3(0,1,0), root.get_node("player").rotation.y)
	
	
	get_tree().current_scene.add_child(n)
	

func CrystalEffects(pos,type):
	var new = chris[type].instance()
	
	new.transform = pos
	
	root.add_child(new)
