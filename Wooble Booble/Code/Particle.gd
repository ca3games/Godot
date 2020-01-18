extends Node2D

func _ready():
	$CPUParticles2D.emitting = true


func _on_Timer_timeout():
	self.queue_free()
