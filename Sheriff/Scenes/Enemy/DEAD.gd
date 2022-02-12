extends "res://Code/Battle/Enemies/BASE STATE.gd"

export(PackedScene) var AmmoBasic


func Physics(delta):
	FSM.state_machine.travel("Dead")

func DieEnd():
	if (randi()%4 == 2):
		var tmp = AmmoBasic.instance()
		tmp.global_position = FSM.Root.global_position
		FSM.Root.get_parent().PlayerBullets.add_child(tmp)
	FSM.Root.queue_free()
