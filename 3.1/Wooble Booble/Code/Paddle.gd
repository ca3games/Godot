extends KinematicBody2D

var speed = Vector2(0,0)

func _ready():
	pass

func _input(event):
	speed = Vector2(0,0)
	if event is InputEventScreenDrag:
		if event.speed.x != 0:
			speed = event.speed
	
	if event is InputEventKey:
		if event.is_action("LEFT"):
			speed.x = -150
		if event.is_action("RIGHT"):
			speed.x = 150

func _physics_process(delta):
	speed.y = 0
	move_and_collide(speed * delta)
	