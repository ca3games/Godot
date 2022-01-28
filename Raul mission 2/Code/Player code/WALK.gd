extends "res://Code/Player code/Basic State.gd"

func Update(delta):	
	if Input.is_action_pressed("BOMB"):
		#FSM.ChangeState("BOMB")
		pass
	if Input.is_action_just_released("Punch"):
		FSM.ChangeState("PUNCH")
	if FSM.direction == Vector2.ZERO:
		FSM.ChangeState("IDLE")
	
	get_tree().get_root().get_node("Map").WALKMANA()

func Physics(delta):
	FSM.state_machine.travel("WALK")
	FSM.AnimTree.set("parameters/WALK/blend_position", FSM.old_dir)
	
	var dir = FSM.old_dir * FSM.vel * delta
	dir.y *= -1
	FSM.Root.move_and_collide(Vector2(dir.x, dir.y), false)
