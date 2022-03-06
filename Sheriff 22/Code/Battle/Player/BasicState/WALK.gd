extends "res://Code/Battle/Player/BasicState/Basic State.gd"

func Update(delta):	
	if FSM.direction == Vector2.ZERO:
		FSM.ChangeState("IDLE")
	
	if Input.is_action_just_released("SHOOT") and Variables.GetAmmo(Variables.currentgun) >= 1:
		Variables.ConsumeAmmo(Variables.currentgun)
		FSM.Root.GUI.SetAmmoBasic(Variables.GetAmmo(Variables.currentgun))
		$"/root/Battle/Sounds".GunShoot()
		ShootBullets()
	
	if Input.is_action_just_released("MELEE"):
		FSM.ChangeState("KICK")
	
func Physics(delta):
	FSM.state_machine.travel("WALK")
	FSM.AnimTree.set("parameters/WALK/blend_position", FSM.old_dir)
	
	var dir = FSM.old_dir * FSM.vel * delta
	dir.y *= -1
	FSM.Root.move_and_collide(Vector2(dir.x, dir.y), false)
