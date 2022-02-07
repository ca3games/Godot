extends "res://Code/Battle/Player/BasicState/Basic State.gd"

func Update(delta):	
		
	if FSM.direction != Vector2.ZERO:
		FSM.ChangeState("WALK")
	

func Physics(delta):
	FSM.state_machine.travel("IDLE")
	FSM.AnimTree.set("parameters/IDLE/blend_position", FSM.old_dir)
