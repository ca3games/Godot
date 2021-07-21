extends Spatial

func DIE():
	get_tree().get_root().get_node("Map/GUI").KILL()
	$"../../".GuineasManager.ResetTargets()
	yield(get_tree(), "idle_frame")
	$"../../".queue_free()

func GuineaDIE():
	get_tree().get_root().get_node("Map/GUI").GUINEAKILL()
	$"../../".GuineasManager.ResetTargets()
	yield(get_tree(), "idle_frame")
	$"../../".queue_free()
