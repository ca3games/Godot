extends Node2D

onready var veneco = preload("res://Scenes/Veneco.tscn")
var enemy = 0
var level = 1

func _ready():
	set_process(true)
	
func _process(delta):
	if get_tree().get_nodes_in_group("Veneco").size() < 1:
		if enemy > 5:
			level += 1
			enemy = 0
		else:
			enemy += 1
		for x in range(level):
			var e = veneco.instance()
			var tmp = Vector2(0,0)
			tmp.x = rand_range(get_node("/root/Node/topleft").get_global_pos().x, get_node("/root/Node/topright").get_global_pos().x)
			tmp.y = rand_range(get_node("/root/Node/topleft").get_global_pos().y, get_node("/root/Node/bottomleft").get_global_pos().y)
			e.set_global_pos(tmp)
			get_node("/root/Node/YSort").add_child(e)