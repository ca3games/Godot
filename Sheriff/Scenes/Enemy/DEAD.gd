extends "res://Code/Battle/Enemies/BASE STATE.gd"

export(PackedScene) var AmmoBasic


func Physics(delta):
	FSM.state_machine.travel("Dead")

func DieEnd():
	var chance = 10 - FSM.Root.level + 1
	if (randi()%chance > chance / 2.2):
		Sounds.PlayAmmoBasic()
		var tmp = AmmoBasic.instance()
		tmp.global_position = FSM.Root.global_position
		FSM.Root.get_parent().PlayerBullets.add_child(tmp)
	FSM.Root.queue_free()
