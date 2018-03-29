extends KinematicBody2D
var vel
var speed
var left
var up

func _ready():
	vel = 5
	set_fixed_process(true)
	speed = Vector2(vel, vel)

func _fixed_process(delta):
	if is_colliding():
		var object = get_collider().get_name()
		if object == "Left":
			left = false
		if object == "Right":
			left = true
		if object == "Up":
			up = false
		if object == "Down":
			up = true
		if object == "Player":
			up = !up
	
	if left:
		speed.x = -vel
	else:
		speed.x = vel
	if up:
		speed.y = -vel
	else:
		speed.y = vel
	
	move(speed)