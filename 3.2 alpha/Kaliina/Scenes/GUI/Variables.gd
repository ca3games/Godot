extends Node2D

func _input(event):
	if Input.is_action_just_released("PAUSE"):
		get_tree().paused = !get_tree().paused

