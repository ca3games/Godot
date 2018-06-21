extends RigidBody

var speed = Vector2(0,0)
var vel = 3
enum direction {left, right, top, down, lefttop, leftdown, rightup, rightdown}
var left = false
var up = false
var right = false
var down = false

var last = direction.down
var direcion = direction.down

func _ready():
	set_process_input(true)

func _process(delta):
	pass

func _input(event):
	speed = Vector2(0,0)
	if Input.is_action_pressed("UP"):
		speed.y = -vel
		up = true
		last = direction.top
	else:
		up = false
	if Input.is_action_pressed("DOWN"):
		speed.y = vel
		down = true
		last = direction.down
	else:
		down = false
	if Input.is_action_pressed("LEFT"):
		speed.x = -vel
		left = true
		if Input.is_action_pressed("UP"):
			last = direction.lefttop
		elif Input.is_action_pressed("DOWN"):
			last = direction.leftdown
		else:
			last = direction.left	
	else:
		left = false
	if Input.is_action_pressed("RIGHT"):
		speed.x = vel
		right = true
		if Input.is_action_pressed("UP"):
			last = direction.rightup
		elif Input.is_action_pressed("DOWN"):
			last = direction.rightdown
		else:
			last = direction.left
	else:
		right = false
	self.linear_velocity = Vector3(speed.x, 0, speed.y)