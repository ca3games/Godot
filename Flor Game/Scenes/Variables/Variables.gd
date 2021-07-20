extends Node

export(String) var GameOver
export(String) var GameWin

func _ready():
	pass

func GameOver():
	get_tree().change_scene(GameOver)
