extends Timer

onready var label = $"../Canvas/TIMER"

func _SetClock(count):
	self.start((count + 60)*3)

func _process(delta):
	var time = int(self.time_left/3)
	label.text = str(time)
	if time < 1:
		get_tree().get_root().get_node("Spatial").GameOver()