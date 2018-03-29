extends KinematicBody2D

var speed
var vel

func _ready():
	vel = 5
	speed = 0
	set_process_input(true)
	set_fixed_process(true)
	set_process(true)
	
func _input(event):
	if event.type == InputEvent.SCREEN_DRAG:
		if get_global_mouse_pos().x < get_pos().x - vel:
			speed = -vel
		if get_global_mouse_pos().x > get_pos().x + vel:
			speed = vel

func _process(delta):
	speed /= 2

func _fixed_process(delta):
	move(Vector2(speed, 0))