extends Node

var level = 1
var wave = 1
var score = 0
var best_score = 0

func AddScore(new):
	score += new
	get_tree().get_root().get_node("Root/GUI/SCORE").text = "SCORE: " + str(score)

func SetScore(new):
	score = new
	get_tree().get_root().get_node("Root/GUI/SCORE").text = "SCORE: " + str(score)	

func Game_Over():
	if best_score < score:
		best_score = score
	get_tree().change_scene("res://Scenes/Menues/Intro.tscn")
	get_tree().paused = false
