extends "res://Code/Player code/Basic State.gd"

var start = true
export(String) var oneshot
export(String) var anim_name

func Update(delta):
	FSM.state_machine.travel("PUNCH")
	FSM.AnimTree.set("parameters/PUNCH/blend_position", FSM.old_dir)

func EndAnim():
	FSM.ChangeState("IDLE")
