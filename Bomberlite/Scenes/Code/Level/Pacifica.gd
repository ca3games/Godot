extends RigidBody

var speed = Vector2(0,0)
var vel = 1
enum direction {center, centerback, left, right, top, down, lefttop, leftdown, rightup, rightdown}
var left = false
var up = false
var right = false
var down = false
var back = false

var last = direction.down
var direcion = direction.down

func _ready():
	set_process_input(true)
	get_node("AnimationPlayer").play("IDLE")

func _input(event):
	if back:
		last = direction.centerback
	else:
		last = direction.center
	
	speed = Vector2(0,0)
	if Input.is_action_pressed("UP"):
		up = true
		last = direction.top
		back = true
	else:
		up = false
	if Input.is_action_pressed("DOWN"):
		down = true
		last = direction.down
		back = false
	else:
		down = false
	if Input.is_action_pressed("LEFT"):
		left = true
		if Input.is_action_pressed("UP"):
			last = direction.lefttop
		elif Input.is_action_pressed("DOWN"):
			last = direction.leftdown
		elif Input.is_action_pressed("RIGHT"):
			last = direction.center
		else:
			last = direction.left	
	else:
		left = false
	if Input.is_action_pressed("RIGHT"):
		right = true
		if Input.is_action_pressed("UP"):
			last = direction.rightup
		elif Input.is_action_pressed("DOWN"):
			last = direction.rightdown
		elif Input.is_action_pressed("LEFT"):
			last = direction.center
		else:
			last = direction.right
	else:
		right = false
		
	match last:
		direction.center:
			speed.x = 0
			speed.y = 0
		direction.right:
			speed.x = vel
			speed.y = 0
		direction.left:
			speed.x = -vel
			speed.y = 0
		direction.top:
			speed.y = -vel
			speed.x = 0
		direction.down:
			speed.y = vel
			speed.x = 0
		direction.rightup:
			speed.y = -vel
			speed.x = vel
		direction.rightdown:
			speed.x = vel
			speed.y = vel
		direction.lefttop:
			speed.x = -vel
			speed.y = -vel
		direction.leftdown:
			speed.x = -vel
			speed.y = vel
		
	self.linear_velocity = Vector3(speed.x, 0, speed.y)
	
	match last:
		direction.centerback:
			get_node("AnimatedSprite3D").flip_h = false
			if get_node("AnimationPlayer").current_animation != "IdleBack":
				get_node("AnimationPlayer").play("IdleBack")
		direction.center:
			get_node("AnimatedSprite3D").flip_h = false
			if get_node("AnimationPlayer").current_animation != "IDLE":
				get_node("AnimationPlayer").play("IDLE")
		direction.down:
			get_node("AnimatedSprite3D").flip_h = false
			if down:
				if get_node("AnimationPlayer").current_animation != "WalkingFront":
					get_node("AnimationPlayer").play("WalkingFront")
			else:
				get_node("AnimationPlayer").play("IDLE")
		direction.left:
			get_node("AnimatedSprite3D").flip_h = true
			if left:
				if get_node("AnimationPlayer").current_animation != "WalkingFront":
					get_node("AnimationPlayer").play("WalkingFront")
			else:
				get_node("AnimationPlayer").play("IDLE")
		direction.right:
			get_node("AnimatedSprite3D").flip_h = false
			if right:
				if get_node("AnimationPlayer").current_animation != "WalkingFront":
					get_node("AnimationPlayer").play("WalkingFront")
			else:
				get_node("AnimationPlayer").play("IDLE")
		direction.top:
			get_node("AnimatedSprite3D").flip_h = true
			if top:
				if get_node("AnimationPlayer").current_animation != "Back Walk":
					get_node("AnimationPlayer").play("Back Walk")
			else:
				get_node("AnimationPlayer").play("IdleBack")
		direction.rightup:
			get_node("AnimatedSprite3D").flip_h = true
			if top:
				if get_node("AnimationPlayer").current_animation != "Back Walk":
					get_node("AnimationPlayer").play("Back Walk")
			else:
				get_node("AnimationPlayer").play("IdleBack")
		direction.rightdown:
			get_node("AnimatedSprite3D").flip_h = false
			if down:
				if get_node("AnimationPlayer").current_animation != "WalkingFront":
					get_node("AnimationPlayer").play("WalkingFront")
			else:
				get_node("AnimationPlayer").play("IDLE")
		direction.lefttop:
			get_node("AnimatedSprite3D").flip_h = false
			if top:
				if get_node("AnimationPlayer").current_animation != "Back Walk":
					get_node("AnimationPlayer").play("Back Walk")
			else:
				get_node("AnimationPlayer").play("IdleBack")
		direction.leftdown:
			get_node("AnimatedSprite3D").flip_h = true
			if down:
				if get_node("AnimationPlayer").current_animation != "WalkingFront":
					get_node("AnimationPlayer").play("WalkingFront")
			else:
				get_node("AnimationPlayer").play("IDLE")