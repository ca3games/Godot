extends Node

var winner = false

func GameOver():
	get_tree().change_scene("res://Scenes/Menues/Winner.tscn")
