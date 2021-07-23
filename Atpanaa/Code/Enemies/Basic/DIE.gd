extends Spatial

export(NodePath) var RootPath
onready var Root = get_node(RootPath)

func DIE():
	get_tree().get_root().get_node("Map/GUI").KILL()
	$"../../".queue_free()

func GuineaDIE():
	get_tree().get_root().get_node("Map/GUI").GUINEAKILL()
	$"../../".queue_free()

func BossDie():
	get_tree().get_root().get_node("Map/GUI").BOSSCOOKIE()
	$"../../".queue_free()
