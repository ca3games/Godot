extends Node

var score = 0
var last_score = 0

func _ready():
	pass

func _veneco():
	score += 1
	get_node("/root/Node/Penecos").set_text("PENECOS MUERTOS: " + str(score))