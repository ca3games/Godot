extends YSort

export(NodePath) var MapNavigationPath
onready var MapNavigation = get_node(MapNavigationPath)

export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)


func _process(delta):
	if get_child_count() == 0:
		$"../../".levelmanager.ChangeScene("DUNGEON")
