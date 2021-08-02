extends "res://Code/Player code/Basic State.gd"

func Update(delta):	
	if FSM.direction == Vector2.ZERO:
		FSM.ChangeState("IDLE")
	if Input.is_action_pressed("BOMB"):
		FSM.ChangeState("BOMB")
	
	get_tree().get_root().get_node("Map").WALKMANA()

func Physics(delta):
	FSM.AnimTree["parameters/MOVEMENT/WALK/blend_position"] = FSM.old_dir
	if is_instance_valid(state_machine):
		state_machine.travel("WALK")
	
	var dir = FSM.old_dir * FSM.vel * delta
	dir.y *= -1
	FSM.Root.move_and_collide(Vector3(dir.x, 0, dir.y), false)
