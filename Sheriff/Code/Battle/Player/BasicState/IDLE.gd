extends "res://Code/Battle/Player/BasicState/Basic State.gd"

func Update(delta):	
		
	if FSM.direction != Vector2.ZERO:
		FSM.ChangeState("WALK")
		
	if Input.is_action_just_released("SHOOT") and FSM.Root.AmmoBasic >= 1:
		FSM.Root.AmmoBasic -= 1
		FSM.Root.GUI.SetAmmoBasic(FSM.Root.AmmoBasic)
		Sounds.GunShoot()
		ShootBullets()
	

func Physics(delta):
	FSM.state_machine.travel("IDLE")
	FSM.AnimTree.set("parameters/IDLE/blend_position", FSM.old_dir)
