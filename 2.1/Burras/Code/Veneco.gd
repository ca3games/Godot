extends RigidBody2D

enum STATE { idle, walk_left, walk_right, back_left, back_right }
var direcion = STATE.idle
var chase = false
var speed = Vector2(0,0)
var vel = 50
var timer = 3
var timer_attack = 5

onready var bullet = preload("res://Scenes/Bullet.tscn")

func _ready():
	get_node("AnimationPlayer").play("IDLE")
	set_process(true)
	
func _process(delta):
	_ai(delta)
	if chase:
		_chase()
	_move()
	
func _ai(delta):
	if timer < 0:
		timer = randi()%4+1
		var d = randi()%5 + 1
		if d > 3:
			chase = false
		else:
			chase = true
	else:
		timer -= delta
	if timer_attack < 0:
		timer_attack = randf()*5+1
		var b = bullet.instance()
		b.set_pos(get_pos())
		get_node("/root/Node/YSort/").add_child(b)
	else:
		timer_attack -= delta
		
func _chase():
	var negrito = get_node("/root/Node/YSort/Negrito")
	var distance = get_global_pos().distance_to(negrito.get_global_pos())
	if distance < 70:
		speed = Vector2(0,0)
	else:
		if negrito.get_global_pos().x < get_global_pos().x :
			speed.x = -vel
		elif negrito.get_global_pos().x > get_global_pos().x :
			speed.x = vel
		else:
			speed.x = 0
		if negrito.get_global_pos().y < get_global_pos().y :
			speed.y = -vel
		if negrito.get_global_pos().y > get_global_pos().y :
			speed.y = vel
	if !chase:
		speed = Vector2(0,0)
	set_linear_velocity(speed)
		
func _move():
	if speed.x < 0:
		if speed.y < 0:
			if get_node("AnimationPlayer").get_current_animation() != "WalkingLeft":
				get_node("AnimationPlayer").play("WalkingLeft")
		else:
			if get_node("AnimationPlayer").get_current_animation() != "Walking Back Left":
				get_node("AnimationPlayer").play("Walking Back Left")
	else:
		if speed.y < 0:
			if get_node("AnimationPlayer").get_current_animation() != "Walking":
				get_node("AnimationPlayer").play("Walking")
		else:
			if get_node("AnimationPlayer").get_current_animation() != "Walking Back":
				get_node("AnimationPlayer").play("Walking Back")
	if speed == Vector2(0,0):
		if get_node("AnimationPlayer").get_current_animation() != "IDLE":
			get_node("AnimationPlayer").play("IDLE")	
	