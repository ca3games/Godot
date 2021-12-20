extends Node2D


func _ready():
	yield(get_tree(), "idle_frame")
	var ports = $"../PythonCode".GetPortsSize()
	for i in ports:
		$"../OutputPorts".add_item($"../PythonCode".GetPortName(i), i)
