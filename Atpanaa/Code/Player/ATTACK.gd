extends "res://Code/Player/BaseState.gd"

func Physics(delta):
	FSM.Root.move_and_collide(Vector3.ZERO, false)
