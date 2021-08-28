extends Node2D

export(NodePath) var FSMPath
onready var FSM = get_node(FSMPath)

func Update(delta):
	pass

func Physics(delta):
	var dir = FSM.Direction * FSM.Speed * delta
	
	FSM.Root.move_and_collide(dir)
