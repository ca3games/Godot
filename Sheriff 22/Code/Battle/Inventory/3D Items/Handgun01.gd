extends Spatial

export(bool) var current
export(float) var rot

func _ready():
	pass

func _process(delta):
	if not current:
		return
	
	$gun.rotate_y(rot)
	
func TurnOFF():
	$gun.rotation_degrees.y = 0
	current = false
	
func TurnON():
	current = true
