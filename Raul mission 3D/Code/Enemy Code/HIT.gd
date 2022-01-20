extends Node

export(NodePath) var FSMPath
onready var FSM = get_node(FSMPath)


func HIT(force):
	FSM.get_parent().add_force(force, Vector3.ZERO)
