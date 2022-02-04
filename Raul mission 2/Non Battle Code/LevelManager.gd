extends Node2D

export(PackedScene) var Dungeon
export(PackedScene) var Battle

func _ready():
	AddScene("DUNGEON")
	
func ChangeScene(scene):
	var child = $ViewportContainer/Viewport.get_child(0)
	child.queue_free()
	AddScene(scene)

func AddScene(scene):
	var tmp
	match(scene):
		"DUNGEON" : tmp = Dungeon.instance()
		"BATTLE" : tmp = Battle.instance()
	$ViewportContainer/Viewport.add_child(tmp)
