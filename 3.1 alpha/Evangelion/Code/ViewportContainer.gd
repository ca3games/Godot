extends ViewportContainer

onready var camera = get_node("/root/Node/Camera2D")
var off = Vector2(-515,-298)

func _ready():
	pass # Replace with function body.

func _process(delta):
	rect_global_position = camera.position + off
