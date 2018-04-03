extends Node

var z = -3
var level = 1
var score = 0
var record = 0
var lasttime = 99

func _gameover():
	if score > record:
		record = score
	get_tree().change_scene("res://Scenes/GameOver.tscn")
	
func _endlevel():
	lasttime = round(get_tree().get_root().get_node("Spatial/TIMER").get_time_left())
	get_tree().change_scene("res://Scenes/Bonus.tscn")

func _endleveltransition():
	get_tree().get_root().get_node("Spatial/Transition")._close()

func _startlevel():
	lasttime = 99
	get_tree().change_scene("res://Scenes/main.tscn")