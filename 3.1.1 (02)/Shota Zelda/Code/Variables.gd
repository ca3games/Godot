extends Node

onready var playerattack = 10

func ResetMap():
	get_tree().change_scene("res://Scenes/Level/Test.tscn")