extends MeshInstance


var isOnFire = false

func _ready():
	$CPUParticles.emitting = false
	
	





func _on_damangeEmitSense_hit():
	$CPUParticles.emitting = true
	$Timer.start()
	


func _on_Timer_timeout():
	self.queue_free()
