extends Spatial


var newC = load("res://Player/CrystalThrowing/Thrown Crystal.tscn")

var chris ={
	
		"fire": load("res://Player/CrystalThrowing/TypesOfCrystals/fireCrystalMokup.tscn"),
		"ice": load("res://Player/CrystalThrowing/TypesOfCrystals/iceMockup.tscn")

}
onready var root = get_tree().current_scene

func _process(delta):
	pass
	
#Called by the PLayer when they click. Type is given to the crystal object,
#and is used when the crystal hits teh ground.
func throwCrystal(type):
	
	
	
	var n = newC.instance()
	
	#print(get_tree().current_scene.name)
	
	n.type = type
	
	n.translation = root.get_node("player").translation
	n.rotation = root.get_node("player").rotation
#	n.dir =  root.get_node("player/Target").translation - root.get_node("player").translation

	n.dir = n.dir.rotated(Vector3(0,1,0), root.get_node("player").rotation.y)
	
	get_tree().current_scene.add_child(n)
	
#Called by the Crystal Object once it hits the floor
func CrystalEffects(pos,type):
	var new = chris[type].instance()
	
	new.transform = pos
	
	root.add_child(new)
