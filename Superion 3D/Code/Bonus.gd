extends Node2D

var score
var time
var tmp

func _ready():
	time = Variables.lasttime
	score = Variables.score
	tmp = time
	set_process(true)

func _process(delta):
	if tmp > 0.5:
		tmp -= delta * 20
		score += Variables.level * 4
		get_node("time").set_text(str(round(tmp)))
		get_node("score").set_text(str(score))
	else:
		Variables.score = score
		Variables._startlevel()
