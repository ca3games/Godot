extends Node2D

func _easy():
	Variables.Dificulty = Variables.dificulty.easy
	Variables.SetDificulty()
	get_tree().change_scene("res://Scenes/Level/Basic Camera Setup.tscn")


func _normal():
	Variables.Dificulty = Variables.dificulty.normal
	Variables.SetDificulty()
	get_tree().change_scene("res://Scenes/Level/Basic Camera Setup.tscn")
	
func _hard():
	Variables.Dificulty = Variables.dificulty.hard
	Variables.SetDificulty()
	get_tree().change_scene("res://Scenes/Level/Basic Camera Setup.tscn")
