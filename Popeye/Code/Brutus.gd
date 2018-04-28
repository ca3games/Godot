extends RigidBody2D

enum STATE  { Idle, walk}
var ai = STATE.Idle
var vel = 30
var timer = -99

func _ready():
	set_process(true)
	ai = STATE.walk
	
func _process(delta):
	if timer < 0:
		_think()
	else:
		timer -= delta
	
	if ai == STATE.Idle:
		_idle()
	elif ai == STATE.walk:
		_walk()
	
func _think():
	var decision = randi()%5 + 1
	if decision < 3:
		ai = STATE.walk
		timer = 1
	else:
		ai = STATE.Idle
		timer = 1.5

func _idle():
	if get_node("AnimationPlayer").get_current_animation() != "IDLE":
		get_node("AnimationPlayer").play("IDLE")
	set_linear_velocity(Vector2(0,0))
	
func _walk():
	if get_node("AnimationPlayer").get_current_animation() != "WALK":
		get_node("AnimationPlayer").play("WALK")
	set_linear_velocity(Vector2(-vel, 0))
	