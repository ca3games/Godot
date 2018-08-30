extends Node

var score = 0
var level = 1
var combo = 0
var combototal = 0

var recordscore = 0

func _ready():
	pass
	
func _begin():
	score = 0
	combo = 0
	level = 1
	get_node("/root/Node/Score")._text(str(score))

func _score():
	if combo > 9:
		level += 1
		combo = 0
	else:
		combo += 1
	get_node("/root/Node/Level").set_text("LEVEL: " + str(level))
	var time = get_node("/root/Node/Time").time
	score += int(time * level * combototal / 100)
	get_node("/root/Node/Score").set_text(str(score))

func fanfare():
	get_node("SamplePlayer").play("fanfare")

func click():
	get_node("SamplePlayer").play("click")
	
func rotate():
	get_node("SamplePlayer").play("rotate")
	