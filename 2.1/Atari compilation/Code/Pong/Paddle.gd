extends RigidBody2D

var x
var vel = 150
var speed = Vector2(0,0)
onready var TweenNode = get_node("Tween")
var complete = true

func _ready():
	x = get_global_pos().x
	set_fixed_process(true)
	set_process_input(true)
	
	

func _fixed_process(delta):
	set_global_pos(Vector2(x, get_global_pos().y))
	set_linear_velocity(speed)

func _input(event):
	speed.y = 0
	if Input.is_action_pressed("UP"):
		speed.y = -vel
	if Input.is_action_pressed("DOWN"):
		speed.y = vel
	if speed.y == 0:
		if complete:
			TweenNode.interpolate_property(get_node("paddle"), "transform/scale", Vector2(0.8,1.4), Vector2(1,1), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
			TweenNode.start()
			complete = false
	else:
		get_node("paddle").set("transform/scale", Vector2(0.8,1.4)) 
		TweenNode.stop_all()
		complete = true


func _tween_complete( object, key ):
	complete = true
