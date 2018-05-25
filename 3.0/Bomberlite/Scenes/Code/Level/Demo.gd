extends Spatial

func _ready():
	pass
	
func _process(delta):
	self.rotate_y(delta/8)
