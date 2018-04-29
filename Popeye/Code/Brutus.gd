extends RigidBody2D

enum STATE  { Idle, walk, walk_back}
var ai = STATE.Idle
var vel = 30
var timer = -99

func _ready():
	set_process(true)
	ai = STATE.Idle
	
func _process(delta):
	if timer < 0:
		var distance = get_pos().x - get_tree().get_root().get_node("Node2D/Popeye").get_pos().x
		_think(distance)
	else:
		timer -= delta
	
	if ai == STATE.Idle:
		_idle()
	elif ai == STATE.walk:
		_walk()
	elif ai == STATE.walk_back:
		_walkback()
	
func _think(distance):
	if distance > 50:
		print(str(distance))
		var decision = randi()%6 + 1
		if decision < 2:
			ai = STATE.walk
			timer = 1
		elif decision > 5:
			ai = STATE.walk_back
			timer = 1.2
		else:
			ai = STATE.Idle
			timer = 1.5
	else:
		print(str(distance))
		var decision = randi()%6 + 1
		if decision < 4:
			ai = STATE.walk
			timer = 2
		else:
			ai = STATE.walk_back
			timer = 1

func _idle():
	if get_node("AnimationPlayer").get_current_animation() != "IDLE":
		get_node("AnimationPlayer").play("IDLE")
	set_linear_velocity(Vector2(0,0))
	
func _walk():
	if get_node("AnimationPlayer").get_current_animation() != "WALK":
		get_node("AnimationPlayer").play("WALK")
	set_linear_velocity(Vector2(-vel * 1.3, 0))

func _walkback():
	if get_node("AnimationPlayer").get_current_animation() != "WalkBack":
		get_node("AnimationPlayer").play("WalkBack")
	set_linear_velocity(Vector2(vel, 0))
