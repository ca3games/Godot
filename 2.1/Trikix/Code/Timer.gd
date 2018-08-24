extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	
func _process(delta):
	var tmp = int(get_node("/root/Node/Timer").get_time_left())
	get_node("/root/Node/Time").set_text(str(tmp))
