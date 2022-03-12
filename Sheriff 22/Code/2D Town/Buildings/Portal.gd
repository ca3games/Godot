extends StaticBody2D

export(String) var NextScene

func _on_Area2D_body_entered(body):
	if body.is_in_group("PLAYER"):
		get_tree().change_scene(NextScene)
