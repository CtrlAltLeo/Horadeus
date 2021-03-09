extends Spatial


var newC = load("res://Player/CrystalThrowing/Thrown Crystal.tscn")

onready var root = get_tree().current_scene

func _process(delta):
	pass
	
	
func throwCrystal():
	
	var n = newC.instance()
	
	print(get_tree().current_scene.name)
	
	n.translation = root.get_node("player").translation
	n.rotation = root.get_node("player").rotation
#	n.dir =  root.get_node("player/Target").translation - root.get_node("player").translation

	n.dir = n.dir.rotated(Vector3(0,1,0), root.get_node("player").rotation.y)
	
	
	get_tree().current_scene.add_child(n)
	
	
