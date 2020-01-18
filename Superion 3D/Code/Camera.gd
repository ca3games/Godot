extends Camera

var magnitude = 0.05
var time = 0
var original_pos


func _ready():
	original_pos = Vector3(get_translation().x, get_translation().y, get_translation().z)
	set_process(true)

func _process(delta):
	if time > 0:
		var x = rand_range(-magnitude, magnitude)
		var y = rand_range(-magnitude, magnitude)
		var pos = Vector3(x, y, 0)
		self.translate(pos)
		time -= delta
	else:
		self.set_translation(original_pos)
		
func _shake():
	time = 0.2