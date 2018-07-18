extends Label

func _ready():
	set_process(true)
	
func _process(delta):
	var time = round(get_node("../TIMER").get_time_left())
	set_text(str(time))

func _TIMER_timeout():
	Variables._gameover()
