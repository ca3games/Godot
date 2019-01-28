extends Node

onready var Root = $"../../"
var time = true
onready var Ani = $"../../AnimationPlayer"

func _Update():
	if time:
		if Ani.current_animation != "Die":
			Ani.play("Die")
	
func _Physics():
	pass
	
func _end():
	Root._Delete()