extends Spatial

onready var Ani = $"../../AnimationPlayer"

func Update(delta):
	pass
	
func Physics(delta):
	Ani.stop()
