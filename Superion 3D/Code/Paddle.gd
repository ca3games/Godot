extends RigidBody

var right
var vel
var speed


func _ready():
	set_translation(Vector3(get_translation().x, get_translation().y, Variables.z))
	right = true
	speed = 0
	vel = 5
	set_fixed_process(true)
	set_process_input(true)

func _input(event):
	speed = 0
	if Input.is_action_pressed("LEFT"):
		right = false
		speed = -vel
	if Input.is_action_pressed("RIGHT"):
		right = true
		speed = vel

func _fixed_process(delta):
	set_linear_velocity(Vector3(speed, 0, 0))
	set_rotation(Vector3(0,0,0))
