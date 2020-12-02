extends Node2D

onready var cell = preload("res://Code/Tile.gd")
onready var tile = preload("res://Scenes/Cell.tscn")

export (int) var Size
export (int) var offset
var Map = []
onready var origin = $"../MapOrigin".position

func _ready():
	Map = SpawnEmpty(Size)
	SpawnMap(Size)

func SpawnEmpty(size):
	var tmp = []
	for x in range(size):
		tmp.append([])
		for y in range(size):
			tmp[x].append([])
			tmp[x][y] = cell.new()
			tmp[x][y].pos = Vector2(x, y)
	
	return tmp

func SpawnMap(size):
	for x in range(size):
		for y in range(size):
			var tmp = tile.instance()
			tmp.position = Vector2(x*offset + origin.x, y*offset + origin.y)
			Map[x][y].cell = tmp
			Map[x][y].cell.pos = Vector2(x, y)
			$"../Map".add_child(Map[x][y].cell)
