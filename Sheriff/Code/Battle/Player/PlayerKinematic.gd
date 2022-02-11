extends KinematicBody2D

onready var direction = Vector2.DOWN
export(float) var speed
export(int) var damage

func _physics_process(delta):
	var colision = move_and_collide(direction * delta)
	if colision:
		self.queue_free()

func SetSpeed(x):
	direction = Vector2(x.x, x.y*-1) * speed
	
