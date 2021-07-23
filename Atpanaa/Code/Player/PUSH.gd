extends Spatial

export(NodePath) var FSMPath
onready var FSM = get_node(FSMPath)

func ENDANIM():
	FSM.ChangeState("PREVIOUS")
