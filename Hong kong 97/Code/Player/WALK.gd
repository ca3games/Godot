extends "res://Code/Player/BasicState.gd"

func Update(delta):
	var direction = Vector2.ZERO
	var left = false
	var right = false
	var top = false
	var bottom = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("UP"):
		top = true
	if Input.is_action_pressed("DOWN"):
		bottom = true
		
	if left:
		direction.x = -1
	if right:
		direction.x = 1
	if top:
		direction.y = 1
	if bottom:
		direction.y = -1

	if direction != Vector2.ZERO:
		FSM.Direction = direction
	
	if left and not right:
		FSM.LeftRight.play("Left")
	if right and not left:
		FSM.LeftRight.play("Right")
		
	if direction == Vector2.ZERO:
		FSM.ChangeState("IDLE")

func Physics(delta):
	FSM.AnimTree.set("parameters/BLENDWALK/blend_amount", 1)
	FSM.AnimTree.set("parameters/WALK/blend_position", FSM.Direction)
	
	FSM.Root.move_and_collide(FSM.Direction * FSM.Speed * delta * Vector2(1, -1))
	
