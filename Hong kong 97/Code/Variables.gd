extends Node

export(String) var gameoverscreen

var Level = 1

var score = 0

func GameOver():
	get_tree().change_scene(gameoverscreen)

func ChangeScore(newscore):
	score += int(newscore)
	get_tree().get_root().get_node("Battle/GUI/Label").text = str(score)
