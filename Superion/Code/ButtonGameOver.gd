extends Button

func _ready():
	connect("pressed", self, "_on_click")
	
func _on_click():
	Global.level = 1
	Global.score = 0
	get_tree().change_scene("res://Scenes/Title.tscn")
