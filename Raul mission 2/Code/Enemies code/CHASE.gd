extends "res://Code/Enemies code/BASE STATE.gd"

var angle = Vector3.ZERO

func Update(delta):
	angle = FSM.Root.global_transform.origin - FSM.Root.Player.global_transform.origin
	
func Physics(delta):
	FSM.Root.move_and_collide(angle * FSM.vel * delta)
