extends Node2D

export(NodePath) var FSMPath
onready var FSM = get_node(FSMPath)

func Update(delta):
	pass

func Physics(delta):
	FSM.state_machine.travel("KICK")
	FSM.AnimTree.set("parameters/KICK/blend_position", FSM.old_dir)

func CheckInput():
	pass

func End():
	FSM.ChangeState("IDLE")
