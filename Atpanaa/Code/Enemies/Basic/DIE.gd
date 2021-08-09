extends Spatial

export(NodePath) var RootPath
onready var Root = get_node(RootPath)


func DIE():
	Variables.DeadCookie()
	get_tree().get_root().get_node("Map/GUI").KILL()
	$"../../".queue_free()

func GuineaDIE():
	Variables.DeadCookie()
	get_tree().get_root().get_node("Map/GUI").GUINEAKILL()
	$"../../".queue_free()

func BossDie():
	Variables.DeadCookie()
	get_tree().get_root().get_node("Map/GUI").BOSSCOOKIE()
	$"../../".queue_free()
