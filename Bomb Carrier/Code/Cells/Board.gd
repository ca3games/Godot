extends Node2D

onready var Cell = load("res://Code/Cells/Cell.gd")
onready var Tiles = preload("res://Scenes/Board/Cell.tscn")
var Map
var size = Vector2(5,10)
var offset = Vector2(0,0)
var space = 64

func _ready():
	MakeMap()
	yield(get_tree(), "idle_frame")
	$"../Pieces".MakePieces()
	$"../Pieces".SpawnPieces(Map)


func MakeMap():
	Map = []
	
	for x in size.x:
		Map.append([])
		for y in size.y:
			Map[x].append([])
			Map[x][y] = Cell.new()
			Map[x][y].pos = Vector2(x, y)
			var tmp = Tiles.instance()
			tmp.position = Vector2(offset.x + (space * x), offset.y + (space * y))
			Map[x][y].cell = tmp
			if y == 2:
				Map[x][y].cell.Top(false)
			if y == 7:
				Map[x][y].cell.Top(true)
			if y <= 2 or y >= 7:
				Map[x][y].cell.get_node("Cell").modulate = Color.brown
			self.add_child(Map[x][y].cell)
