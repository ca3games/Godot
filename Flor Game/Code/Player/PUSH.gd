extends "res://Code/Player/BaseState.gd"

func EndAnimation():
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

	print(direction)

	if direction != Vector2.ZERO:
		FSM.ChangeState("WALK")
	else:
		FSM.ChangeState("IDLE")
