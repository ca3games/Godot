extends Node

onready var Root = $"../../"
var time = true
onready var Ani = $"../../AnimationPlayer"
var dead = 0

func _Update():
	if time:
		if Ani.current_animation != "Die":
			if dead == 0:
				$"../../Dead".play()
				Ani.play("Die")
				dead += 1
	
func _Physics():
	pass
	
func _end():
	pass

func kill():
	Root._Delete()
