extends Spatial

onready var brick = preload("res://Scenes/Enemy.tscn")

var level = 1

func _ready():
	level = Variables.level
	if level > 9:
		Variables._gameover()
	
	var x = 0
	var y = 0
	var left = get_node("../Walls/Right").get_translation().x
	var right = get_node("../Walls/Left").get_translation().x
	var top = get_node("../Walls/Top").get_translation().y
	var bottom = get_node("../Walls/Bottom").get_translation().y
	var width = right - left
	var height = top - bottom
	
	for i in range (level):
		x += 1
		if x >= 4 :
			x = 1
			y += 1
		var e = brick.instance()
		var size = get_viewport().get_rect().size
		var pos = Vector2((width / 4) * x + left, 6 - (y * 2.5))
		var tmp = Vector3(pos.x, pos.y, Variables.z)
		print(str(level) + " / " + str(tmp.y))
		e.set_translation(tmp)
		get_node("../Spawner").add_child(e)
	
	set_process(true)
	
func _process(delta):
	if get_tree().get_nodes_in_group("Enemy").size() < 1:
		Variables.level += 1
		Variables._endleveltransition()