extends RigidBody2D

var vel = Vector2(0,0)
var speed = 50

func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_pressed("LEFT"):
		vel.x = -speed
	elif Input.is_action_pressed("RIGHT"):
		vel.x = speed
	else:
		vel.x = 0
		
func _process(delta):
	linear_velocity = vel

func _Right_entered(body):
	get_node("/root/Node/Camera2D")

func _Right_exited(body):
	pass # Replace with function body.
