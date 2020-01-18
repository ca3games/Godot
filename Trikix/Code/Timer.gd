extends Label

var time = 20

func _ready():
	set_process(true)
	
func _process(delta):
	time -= delta * Values.level
	get_node("/root/Node/Time").set_text(str(int(time)))
	
	if time < 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
