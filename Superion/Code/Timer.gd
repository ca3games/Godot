extends Timer

func _ready():
	connect("timeout", self, "_timeout")
	set_process(true)

func _process(delta):
	var time = round(self.get_time_left())
	get_tree().get_root().get_node("Node2D/TIME").set_text(str(time))

func _timeout():
	get_tree().change_scene("res://Scenes/GameOver.tscn")