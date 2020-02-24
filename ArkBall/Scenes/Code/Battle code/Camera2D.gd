extends Camera2D

var bouncing = false
var radius = 0.015

func _process(delta):
	if bouncing:
		self.offset_h = rand_range(-radius, radius)
		self.offset_v = rand_range(-radius, radius)

func Bounce():
	bouncing = true
	$Timer.start(0.2)


func _on_Timer_timeout():
	bouncing = false
