extends Label


func _ready():
	get_node("../Level").set_text("LEVEL: " + str(Variables.level))
	set_process(true)

func _process(delta):
	var score = Variables.score
	set_text("SCORE: " + str(score))