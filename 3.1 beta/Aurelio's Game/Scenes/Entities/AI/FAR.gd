extends Node

onready var Root = $"../../"

func _Update():
	if Root.Far:
		Root._ChangeStatus("chase")
	
func _Physics():
	pass