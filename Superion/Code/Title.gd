extends Button

func _ready():
	connect("pressed", self, "_Buttonreleased")
	pass


func _Buttonreleased():
	get_tree().change_scene("res://Scenes/main.tscn")
