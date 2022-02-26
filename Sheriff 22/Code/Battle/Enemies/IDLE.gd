extends "res://Code/Battle/Enemies/BASE STATE.gd"

func Physics(delta):
	FSM.state_machine.travel("IDLE")
	FSM.AnimTree.set("parameters/IDLE/blend_position", FSM.direction)
