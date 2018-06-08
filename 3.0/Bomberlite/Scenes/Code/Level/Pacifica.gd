extends RigidBody

var speed = Vector2(0,0)
var vel = 3

func _ready():
	set_process_input(true)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

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
	self.linear_velocity = Vector3(speed.x, 0, speed.y)