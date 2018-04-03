extends TextureButton

func _ready():
	if Variables.level >= 9:
		get_node("../WIN").set_text("YOU WON")
	else:
		get_node("../WIN").set_text("GAME OVER")
	connect("pressed", self, "_onpress")
	
	get_node("../SCORE").set_text(str(Variables.score))
	get_node("../RECORD").set_text(str(Variables.record))
	
func _onpress():
	Variables.level = 1
	Variables.score = 0
	get_tree().change_scene("res://Scenes/Title.tscn")
