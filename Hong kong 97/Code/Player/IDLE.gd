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
		
	if left or right or top or bottom:
		FSM.ChangeState("WALK")

func Physics(delta):
	FSM.AnimTree.set("parameters/BLENDWALK/blend_amount", 0)
	FSM.AnimTree.set("parameters/IDLE/blend_position", FSM.Direction)
