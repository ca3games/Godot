extends Camera

var bounds = Vector2(1,1)
var center_x = Vector2(3, -5)
var cameraspeed = Vector2(0,0)
var speed = 3

var Pacificaoffset = Vector3(0,0,0)

func _ready():
	pass
	
func _process(delta):
	var cameraoffset = get_global_transform().origin + Vector3(center_x.x, 0, center_x.y)
	Pacificaoffset = cameraoffset - get_node("/root/Spatial/objects/Pacifica").get_global_transform().origin
	cameraspeed = Vector2(0,0)
	if Pacificaoffset.x < -bounds.x:
		cameraspeed.x = -speed
	if Pacificaoffset.x > bounds.x:
		cameraspeed.x = speed
	if Pacificaoffset.z < -bounds.y:
		cameraspeed.y = -speed
	if Pacificaoffset.z > bounds.y:
		cameraspeed.y = speed
	var target = get_global_transform().origin + Vector3 (center_x.x + cameraspeed.x, 0, center_x.y + cameraspeed.y)
	var pos = get_global_transform().origin + Vector3(center_x.x, 0, center_x.y)
	var distance = (pos - target).normalized() * delta
	global_translate(distance)