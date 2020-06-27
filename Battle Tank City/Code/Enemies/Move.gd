extends Spatial

var direction = Vector2.ZERO
var speed = 5
var home
var blue = true
export (bool) var IsRed = false

func _ready():
	$"../MeshInstance".get_surface_material(0).set("shader_param/HP_texture", 0)
	if IsRed:
		$Red.start(1)

func _physics_process(delta):
	var dir = speed * direction * delta
	$"../".move_and_collide(Vector3(dir.x, 0, dir.y))
	
	match (direction):
		Vector2.DOWN : $"../".set("rotation_degrees", Vector3(0, 0, 0))
		Vector2.UP : $"../".set("rotation_degrees", Vector3(0, 180, 0))
		Vector2.RIGHT : $"../".set("rotation_degrees", Vector3(0, 90, 0))
		Vector2.LEFT : $"../".set("rotation_degrees", Vector3(0, 270, 0))


func ASTAR():
	var pos = $"../".global_transform.origin
	var dir = Vector2.ZERO
	
	if randi()%10 < 5:
		if home.x < pos.x:
			dir.x = -1
		else:
			dir.x = 1
	else:
		if home.z < pos.z:
			dir.y = -1
		else:
			dir.y = 1
	return dir


func _on_Move_timeout():
	randomize()
	var dir = randi()%5 + 1
	
	match(dir):
		1: direction = Vector2.UP
		2: direction = Vector2.RIGHT
		3: direction = Vector2.DOWN
		4: direction = Vector2.LEFT
		5: direction = ASTAR()


func _on_Red_timeout():
	blue = !blue
	$"../MeshInstance".get_surface_material(0).set("shader_param/Red", blue)
