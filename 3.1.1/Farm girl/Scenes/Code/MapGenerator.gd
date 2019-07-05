extends Node

onready var Cell = load("res://Scenes/Code/Cell.gd")
onready var Tile = preload("res://Scenes/RogueMap/Tile.tscn")

func GenerateMap(mapsize, offset):
	var map = []
	for x in range(0, mapsize.x):
		map.append([])
		for y in range(0, mapsize.y):
			map[x].append([])
			map[x][y] = Cell.new()
			map[x][y].pos = Vector2(x, y)
			map[x][y].position = map[x][y].pos * offset
	return map

func InstantiateMap(map, mapsize):
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			map[x][y].Tile = Tile.instance()
			map[x][y].Tile.global_transform.origin = Vector3(map[x][y].position.x, 0, map[x][y].position.y)
			$"../../Tiles".add_child(map[x][y].Tile)
	
