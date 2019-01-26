extends Node

onready var Root = $"../../"

func _ready():
	pass

func _Update():
	if Root.Near == false:
		Root._ChangeStatus("chase")
	
func _Physics():
	pass