extends RigidBody2D
var speed = Vector2(0,0)
var vel = 100

func _ready():
	pass

func _input(event):
	speed = Vector2(0,0)
	if Input.is_action_pressed("LEFT"):
		speed.x = -vel
	if Input.is_action_pressed("RIGHT"):
		speed.x = vel
	if Input.is_action_pressed("UP"):
		speed.y = -vel
	if Input.is_action_pressed("DOWN"):
		speed.y = vel
	linear_velocity = speed