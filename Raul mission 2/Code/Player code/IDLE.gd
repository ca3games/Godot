extends "res://Code/Player code/Basic State.gd"

func Update(delta):	
	
	if Input.is_action_just_released("BOMB"):
		FSM.get_node("BOMB").SpawnBomb()
		
	if FSM.direction != Vector2.ZERO:
		FSM.ChangeState("WALK")
	
	if Input.is_action_just_released("Punch"):
		FSM.ChangeState("PUNCH")
		FSM.current.start = false

func Physics(delta):
	FSM.state_machine.travel("IDLE")
	FSM.AnimTree.set("parameters/IDLE/blend_position", FSM.old_dir)
