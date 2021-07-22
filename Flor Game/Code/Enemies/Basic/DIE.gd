extends Spatial

func DIE():
	get_tree().get_root().get_node("Map/GUI").KILL()
	$"../../".queue_free()

func GuineaDIE():
	get_tree().get_root().get_node("Map/GUI").GUINEAKILL()
	$"../../".queue_free()
