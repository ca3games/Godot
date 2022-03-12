extends "res://Code/Battle/Player/BasicState/Basic State.gd"

func Update(delta):	
		
	if FSM.direction != Vector2.ZERO:
		FSM.ChangeState("WALK")

	if Input.is_action_just_released("SHOOT") and Variables.GetAmmo(Variables.currentgun) >= 1 and !FSM.Root.Town:
		Variables.ConsumeAmmo()
		FSM.Root.GUI.SetAmmoBasic(Variables.GetAmmo(Variables.currentgun))
		$"/root/Battle/Sounds".GunShoot()
		ShootBullets()
	
	if Input.is_action_just_released("MELEE") and !FSM.Root.Town:
		FSM.ChangeState("KICK")
	

func Physics(delta):
	FSM.state_machine.travel("IDLE")
	FSM.AnimTree.set("parameters/IDLE/blend_position", FSM.old_dir)
