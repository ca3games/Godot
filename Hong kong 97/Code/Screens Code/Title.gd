extends Node2D

export(String) var NextScreen

func _process(delta):
	if Input.is_action_just_released("SPACE"):
		get_tree().change_scene(NextScreen)
