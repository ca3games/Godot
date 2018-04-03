extends Button

func _ready():
	connect("pressed", self, "_onpress")
	
func _onpress():
	get_tree().change_scene("res://Scenes/main.tscn")
