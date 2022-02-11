extends "res://Code/Battle/Enemies/BASE STATE.gd"

func Physics(delta):
	FSM.state_machine.travel("Dead")
