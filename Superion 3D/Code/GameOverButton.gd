extends Button

func _ready():
	if Variables.level >= 7:
		get_node("../WIN").set_text("YOU WON")
	else:
		get_node("../WIN").set_text("GAME OVER")
	connect("pressed", self, "_onpress")
	
func _onpress():
	Variables.level = 1
	get_tree().change_scene("res://Scenes/Title.tscn")
