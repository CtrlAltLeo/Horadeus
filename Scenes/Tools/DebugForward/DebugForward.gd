extends Spatial

export var _show_in_game := false

func _ready():
	if !_show_in_game:
		queue_free()
