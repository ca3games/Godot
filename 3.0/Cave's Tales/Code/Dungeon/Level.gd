extends Spatial

onready var empty = preload("res://Scenes/Tiles/Ground.tscn")

var mapa
enum ground { empty, wall }
var offset = 1
var width = 10
var height = 10

func _ready():
	mapa = []
	for x in range(width):
		mapa.append([])
		for y in range(height):
			var t = empty.instance()
			t.global_transform.origin = Vector3(x*offset, 0, y*offset)
			mapa[x].append(t)
			mapa[x][y].x = x
			mapa[x][y].y = y
			
			get_node("/root/Spatial/Map").add_child(mapa[x][y])

