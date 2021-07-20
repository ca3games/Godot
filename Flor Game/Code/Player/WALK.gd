extends "res://Code/Player/BaseState.gd"

func Update(delta):
	var direction = Vector2.ZERO
	var left = false
	var right = false
	var up = false
	var down = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("UP"):
		up = true
	if Input.is_action_pressed("DOWN"):
		down = true
	
	if left:
		direction.x = -1
	if right:
		direction.x = 1
	if up:
		direction.y = -1
	if down:
		direction.y = 1

	if direction != Vector2.ZERO:
		FSM.direction = direction
	else:
		FSM.ChangeState("IDLE")
	
	if Input.is_action_just_released("PUSH"):
		FSM.states.travel("PUSH")
		FSM.ChangeState("ATTACK")

func Physics(delta):
	
	var dir = FSM.direction * FSM.vel * delta
	
	FSM.Root.move_and_collide(Vector3(dir.x, 0, dir.y), false)
	
	var i = FSM.AnimTree.get("parameters/MOVE/MoveBlend/blend_amount")
	if i < 1:
		i += FSM.transpeed * delta
	
	FSM.AnimTree.set("parameters/MOVE/MoveBlend/blend_amount", i)
