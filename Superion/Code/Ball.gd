extends RigidBody2D
var vel
var speed
var left
var up

func _ready():
	vel = 200
	set_fixed_process(true)
	speed = Vector2(vel, vel)
	left = true
	up = true
	connect("body_enter", self, "bodyenter")
	
func _fixed_process(delta):
	if left:
		speed.x = -vel
	else:
		speed.x = vel
	if up:
		speed.y = -vel
	else:
		speed.y = vel
	
	set_linear_velocity(speed)

func _bodyenter( body ):
	if body.get_name() == "Left":
		left = false
	if body.get_name() == "Right":
		left = true
	if body.get_name() == "Up":
		up = false
	if body.get_name() == "Down":
		up = true
	if body.get_name() == "Player":
		up = !up
	if body.is_in_group("Enemy"):
		left = !left
