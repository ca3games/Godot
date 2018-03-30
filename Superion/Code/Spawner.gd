extends Node2D

onready var brick = preload("res://Scenes/Bricks.tscn")

var level = 6

func _ready():
	
	var x = 0
	var y = 0
	
	for i in range (level):
		x += 1
		if x > 4 :
			x = 0
			y += 1
		var e = brick.instance()
		var size = get_viewport().get_rect().size
		var pos = Vector2(size.width / 4 * x, (size.height / 10) * y + 200)
		e.set_pos(pos)
		get_node("../Enemies").add_child(e)
	
	set_process(true)
	
func _process(delta):
	if get_tree().get_nodes_in_group("Enemy").size() < 1:
		pass
