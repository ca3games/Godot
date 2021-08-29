extends Node2D

var step = 1
export(String) var NextScreen

func _process(delta):
	if Input.is_action_just_released("SPACE"):
		step += 1
		$AnimationPlayer.play(str(step))
		
		if step == 5:
			get_tree().change_scene(NextScreen)
