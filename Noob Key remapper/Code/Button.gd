extends Node2D

export (NodePath) var PythonCodePath
onready var PythonCode = get_node(PythonCodePath)
export(NodePath) var OutPutListPath
onready var OutPutList = get_node(OutPutListPath)

func _ready():
	yield(get_tree(), "idle_frame")
	var ports = PythonCode.GetPortsSize()
	for i in ports:
		OutPutList.add_item(PythonCode.GetPortName(i), i)
