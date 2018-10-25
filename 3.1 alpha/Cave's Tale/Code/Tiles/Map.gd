extends Node2D

onready var Tile = preload("res://Scenes/Tiles/Tile.tscn")
enum cell {empty, wall}

var Map
var size = Vector2(10,10)

func _ready():
	Map = []
	
	for x in range(size.x):
		Map.append([])
		for y in range(size.y):
			var t = Tile.instance()
			t.position = Vector2(x*64, y*64)
			t.x = x
			t.y = y
			Map[x].append(t)
			
			get_node("Map").add_child(Map[x][y])
	
	get_node("Camera2D").position = Vector2(size.x/2*64, size.y*64)
