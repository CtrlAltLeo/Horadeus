extends Spatial

export var _editor_only := true

func _ready():
	if _editor_only:
		queue_free()
