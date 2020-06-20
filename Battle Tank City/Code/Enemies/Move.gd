extends Spatial

var direction = Vector2.ZERO
var speed = 5
var home

func _physics_process(delta):
	var dir = speed * direction * delta
	$"../".move_and_collide(Vector3(dir.x, 0, dir.y))
	
	match (direction):
		Vector2.DOWN : $"../".set("rotation_degrees", Vector3(0, 0, 0))
		Vector2.UP : $"../".set("rotation_degrees", Vector3(0, 180, 0))
		Vector2.RIGHT : $"../".set("rotation_degrees", Vector3(0, 90, 0))
		Vector2.LEFT : $"../".set("rotation_degrees", Vector3(0, 270, 0))

func _on_Timer_timeout():
	randomize()
	$"Timer".start(rand_range(0.2, 1))
	var dir = randi()%7 + 1
	
	match(dir):
		1: direction = Vector2.UP
		2: direction = Vector2.RIGHT
		3: direction = Vector2.DOWN
		4: direction = Vector2.LEFT
		_: direction = ASTAR()

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
