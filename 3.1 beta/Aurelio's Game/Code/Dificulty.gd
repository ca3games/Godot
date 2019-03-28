extends Node2D

enum dificulty {easy, normal, hard}
var dif

func _easy():
	if !$Start.playing:
		dif = dificulty.easy
		$Start.play()

func _ChangeScene():
	match(dif):
		dificulty.easy:
			Variables.Dificulty = Variables.dificulty.easy
			Variables.SetDificulty()
			get_tree().change_scene("res://Scenes/Level/Basic Camera Setup.tscn")
		dificulty.normal:
			Variables.Dificulty = Variables.dificulty.normal
			Variables.SetDificulty()
			get_tree().change_scene("res://Scenes/Level/Basic Camera Setup.tscn")
		dificulty.hard:
			Variables.Dificulty = Variables.dificulty.hard
			Variables.SetDificulty()
			get_tree().change_scene("res://Scenes/Level/Basic Camera Setup.tscn")

func _normal():
	if !$Start.playing:
		dif = dificulty.normal
		$Start.play()
	
func _hard():
	if !$Start.playing:
		dif = dificulty.hard
		$Start.play()


func _hover():
	if !$Hover.playing:
		$Hover.play()