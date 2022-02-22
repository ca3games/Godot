extends Node2D

export(NodePath) var customscalepath
onready var customscale = get_node(customscalepath)


func GetKey(key):
	var g = GetInterval(key)
	var n = 999
	
	n = customscale.data["notes"][g]
	return n


func GetOffset(key, scale):
	var i = len(customscale.data["notes"])
	var n = (key + int(scale))% i
	
	return n

func GetInterval(key):
	var n = key % len(customscale.data["notes"])
	
	return n
