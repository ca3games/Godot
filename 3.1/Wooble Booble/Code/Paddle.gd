extends KinematicBody2D

var speed = Vector2(0,0)

func _ready():
	pass

func _input(event):
	speed = Vector2(0,0)
	if event is InputEventScreenDrag:
		if event.speed.x != 0:
			speed = event.speed
	
	if Input.is_action_pressed("LEFT"):
		speed.x = -150
	if Input.is_action_pressed("RIGHT"):
		speed.x = 150

func _physics_process(delta):
	speed.y = 0
	move_and_collide(speed * delta)
	