extends RigidBody2D

var speed = Vector2(0,0)
var last_speed = 0
var vel = 100
var attack = false

func _ready():
	set_process_input(true)
	get_node("AnimationPlayer").play("IDLE")

func _input(event):
	speed = Vector2(0,0)
	
	if !attack:	
		if Input.is_action_pressed("LEFT"):
			speed.x = -vel
			last_speed = -vel
		if Input.is_action_pressed("RIGHT"):
			speed.x = vel
			last_speed = vel
		if Input.is_action_pressed("UP"):
			speed.y = -vel
		if Input.is_action_pressed("DOWN"):
			speed.y = vel
		
		if speed.x == 0:
			if speed.y == 0:
				if get_node("AnimationPlayer").get_current_animation() != "IDLE":
					get_node("AnimationPlayer").play("IDLE")
			if speed.y == vel:
				if get_node("AnimationPlayer").get_current_animation() != "FrontWalk":
					get_node("AnimationPlayer").play("FrontWalk")
			if speed.y == -vel:
				if get_node("AnimationPlayer").get_current_animation() != "BackWalk":
					get_node("AnimationPlayer").play("BackWalk")
		elif speed.x == -vel:
			if speed.y == 0:
				if get_node("AnimationPlayer").get_current_animation() != "LeftWalk":
					get_node("AnimationPlayer").play("LeftWalk")
			if speed.y == vel:
				if get_node("AnimationPlayer").get_current_animation() != "FrontDiagonalLeft":
					get_node("AnimationPlayer").play("FrontDiagonalLeft")
			if speed.y == -vel:
				if get_node("AnimationPlayer").get_current_animation() != "BackDiagonalLeft":
					get_node("AnimationPlayer").play("BackDiagonalLeft")
		else:
			if speed.y == 0:
				if get_node("AnimationPlayer").get_current_animation() != "RightWalk":
					get_node("AnimationPlayer").play("RightWalk")
			if speed.y == vel:
				if get_node("AnimationPlayer").get_current_animation() != "FrontDiagonalRight":
					get_node("AnimationPlayer").play("FrontDiagonalRight")
			if speed.y == -vel:
				if get_node("AnimationPlayer").get_current_animation() != "BackDiagonalRight":
					get_node("AnimationPlayer").play("BackDiagonalRight")
		
		if Input.is_action_pressed("SHOOT"):
			attack = true
			if last_speed >= 0:
				if get_node("AnimationPlayer").get_current_animation() != "AttackRight":
					get_node("AnimationPlayer").play("AttackRight")
			else:
				if get_node("AnimationPlayer").get_current_animation() != "AttackLeft":
					get_node("AnimationPlayer").play("AttackLeft")
	set_linear_velocity(speed)

func _stop():
	attack = false
	get_node("AnimationPlayer").play("IDLE")

func _body_enter( body ):
	if body.is_in_group("Veneco"):
		Score._veneco()
		body.queue_free()
