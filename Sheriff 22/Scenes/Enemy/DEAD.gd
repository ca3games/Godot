extends "res://Code/Battle/Enemies/BASE STATE.gd"

export(PackedScene) var AmmoBasic


func Physics(delta):
	FSM.state_machine.travel("Dead")

func DieEnd():
	var disolve = FSM.Root.DeadDisolve.instance()
	var pos = FSM.Root.get_node("MySprites/AnimatedSprite").global_position
	if FSM.Root.BOSS:
		disolve.scale *= 2
	disolve.global_position = pos
	if FSM.direction.x < 0:
		disolve.Flip(false)
	var colors = FSM.Root.get_node("ColorsCode")
	disolve.SetColor(colors.myjacket, colors.myhat, colors.mypants, colors.myskin)
	FSM.Root.get_parent().add_child(disolve)
	
	var chance = 10 - FSM.Root.level + 1
	if (randi()%chance > chance / 2.2):
		$"/root/Battle/Sounds".PlayAmmoBasic()
		var tmp = AmmoBasic.instance()
		tmp.global_position = FSM.Root.global_position
		FSM.Root.get_parent().PlayerBullets.add_child(tmp)
	FSM.Root.queue_free()
