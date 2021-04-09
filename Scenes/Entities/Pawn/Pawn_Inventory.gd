extends Spatial

export var max_size : int = 8 
export var drop_on_free := true 

var inventory : Array

func _ready():

	pass

func drop_inventory():

	pass

func add(item : Item, index : int = 0) -> Item:
	if inventory[index] == null:
		inventory[index] = item
		return null
	elif inventory[index].name == item.name:
		if inventory[index].stack_size + item.stack_size > item.max_stack_size:
			item.remove_from_stack(inventory[index].add_to_stack(item.stack_size))
			return item
		pass
				
	else: 
		item.remove_from_stack(inventory[index].add_to_stack(item.stack_size))
		item.queue_free()
		return null
	return null

func remove(index : int, frequency: int) -> Item:
	if inventory[index] != null:
		var temp : Item = inventory[index]
		inventory[index] = null
		return temp
	return null

func find(item : Item, start_at := 0) -> int:
	for i in range(start_at,max_size):
		if inventory[i]== item:
			return i;
	return -1
