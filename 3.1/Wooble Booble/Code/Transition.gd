extends Node2D

var loaded = 0

func _ready():
	loaded = 0

func _ToEnter():
	$AnimationPlayer.play("Enter")
	loaded = 1
	
func _ToLeave():
	loaded = 2
	$AnimationPlayer.play("Leave")

func _animation_finished(anim_name):
	get_tree().paused = false
	if loaded == 2:
		Variables.ChangeScene()
