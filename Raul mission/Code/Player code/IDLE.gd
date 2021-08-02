extends "res://Code/Player code/Basic State.gd"

func Update(delta):	
	if FSM.direction != Vector2.ZERO:
		FSM.ChangeState("WALK")
	
	if Input.is_action_pressed("BOMB"):
		FSM.ChangeState("BOMB")
		state_machine.travel("BOMB")

func Physics(delta):
	FSM.AnimTree.set("parameters/MOVEMENT/IDLE/blend_position", FSM.old_dir)
	if is_instance_valid(state_machine):
		state_machine.travel("IDLE")
