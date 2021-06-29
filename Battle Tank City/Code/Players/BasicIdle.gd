extends "res://Code/Players/BasicState.gd"

func Update(delta):

	if Input.is_action_pressed(FSM.sLEFT) or Input.is_action_pressed(FSM.sRIGHT) or Input.is_action_pressed(FSM.sUP) or Input.is_action_pressed(FSM.sDOWN):
		FSM.ChangeState("WALK")
