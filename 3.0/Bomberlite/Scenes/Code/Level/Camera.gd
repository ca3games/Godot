extends Camera

var Pacificapos = Vector2(0,0)
var camerapos = Vector2(0,0)
var offset = Vector2(1,1)
var center_x = Vector2(3, 7)
var cameraspeed = Vector2(0,0)

func _ready():
	pass
	
func _process(delta):
	Pacificapos = Vector2(get_tree().get_root().get_node("Spatial/objects/Pacifica").get_global_transform().origin.x, get_tree().get_root().get_node("Spatial/objects/Pacifica").get_global_transform().origin.z)
	camerapos = Vector2(get_tree().get_root().get_node("Spatial/Camera").get_global_transform().origin.x, get_tree().get_root().get_node("Spatial/Camera").get_global_transform().origin.z)

func _physics_process(delta):
	cameraspeed = Vector2(0,0)
	if Pacificapos.x <= center_x.x + (camerapos.x - offset.x):
		cameraspeed.x = -delta
	if Pacificapos.x >= (camerapos.x + offset.x) + center_x.x:
		cameraspeed.x = delta
	if Pacificapos.y < camerapos.y - offset.y - center_x.y:
		cameraspeed.y = -delta
	if Pacificapos.y > camerapos.y + offset.y - center_x.y:
		cameraspeed.y = delta
	self.global_translate(Vector3(cameraspeed.x * 2, 0, cameraspeed.y * 2))