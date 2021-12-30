extends Node2D

export(NodePath) var customscalepath
onready var customscale = get_node(customscalepath)


func GetKey(key):
	var g = GetInterval(key)
	var i = GetOffset(g, customscale.offset)
	var n = 999
	
	n = customscale.notes[i]
	return n


func GetOffset(key, scale):
	var n = (key + scale)% len(customscale.notes)
	
	return n

func GetInterval(key):
	var n = key % len(customscale.notes)
	
	return n
