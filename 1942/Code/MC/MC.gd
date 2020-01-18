extends KinematicBody2D

var speed = Vector2.ZERO
var vel = 150
var vel_stop = 70

func _ready():
	pass # Replace with function body.


func _process(delta):
	
	if Input.is_action_pressed("LEFT") and speed.x > -vel:
		speed.x -= delta * vel
	if Input.is_action_pressed("RIGHT") and speed.x < vel:
		speed.x += delta * vel
	if Input.is_action_pressed("TOP") and speed.y > -vel:
		speed.y -= delta * vel
	if Input.is_action_pressed("BOTTOM") and speed.y < vel:
		speed.y += delta * vel
	
	if speed.x < 0:
		speed.x += delta * vel_stop
	if speed.x > 0:
		speed.x -= delta * vel_stop
	if speed.y < 0:
		speed.y += delta * vel_stop
	if speed.y > 0:
		speed.y -= delta * vel_stop

func _physics_process(delta):
	self.move_and_slide(speed)