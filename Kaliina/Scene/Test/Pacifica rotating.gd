extends Spatial

var speed = 0.01

func _ready():
	pass

func _process(delta):
	rotate_y(speed)
