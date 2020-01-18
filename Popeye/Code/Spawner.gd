extends Node2D

onready var heart = preload("res://Scenes/Heart.tscn")

var timer
var size
var width
var offset

func _ready():
	timer = 3
	size = get_viewport().get_visible_rect().size.x
	offset = size / 5
	width = int (round(size - offset))

func _process(delta):
	if timer < 0:
		if get_tree().get_nodes_in_group("Heart").size() < 2:
			timer = randi()%10+1
			var e = heart.instance()
			var x = randi()%width + 1
			x += offset/2
			var pos = Vector2(x,0)
			e.position = pos
			add_child(e)
	else:
		timer -= delta
