extends KinematicBody

export(float) var speed
onready var direction = Vector2(speed, speed)

func _ready():
	print(direction)

func _physics_process(delta):
	
	var velocity = move_and_slide(Vector3(direction.x, direction.y, 0))
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print(collision.collider.name)
		if collision.collider.name == "LEFT" or collision.collider.name == "RIGHT" :
			direction.x *= -1
		if collision.collider.name == "TOP" or collision.collider.name == "BOTTOM":
			var b = Vector2.bounce(direction)
			direction.y *= -1
