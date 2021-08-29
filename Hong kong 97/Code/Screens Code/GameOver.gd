extends Node2D

export (String) var NextScreen


func _on_GameOver_timeout():
	Variables.score = 0
	get_tree().change_scene(NextScreen)
