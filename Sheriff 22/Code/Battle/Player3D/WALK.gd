extends "res://Code/Battle/Player3D/Basic FSM.gd"


func Update(delta):	
	if FSM.direction == Vector2.ZERO:
		FSM.ChangeState("IDLE")
	
func Physics(delta):
	FSM.state_machine.travel("WALK")
	FSM.AnimTree.set("parameters/WALK/blend_position", FSM.old_dir)
	
	var dir = FSM.old_dir * FSM.vel * delta
	dir.y *= -1
	FSM.Root.move_and_collide(Vector3(dir.x, 0, dir.y), false)
