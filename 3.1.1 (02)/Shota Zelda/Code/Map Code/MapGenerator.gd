extends Node

onready var Tile = load("res://Code/Map Code/Tile.gd")
onready var tile_scene = preload("res://Scenes/Tiles/TileEmpty.tscn")
onready var tile_wall = preload("res://Scenes/Tiles/TileWall.tscn")

var Map = []
var mapsize = Vector2(21,11)
var mappos = Vector2(16,80)
var mapoffset = 16

func _ready():
	MakeMap()
	MakeDungeon()
	InstantiateMap()


func MakeMap():
	for x in range(0, mapsize.x):
		Map.append([])
		for y in range(0, mapsize.y):
			Map[x].append([])
			Map[x][y] = Tile.new()
			Map[x][y].pos = Vector2(x, y)
			Map[x][y].position = Vector2(x, y) * mapoffset + mappos
			if x == 0 or y == 0 or x == mapsize.x-1 or y == mapsize.y-1:
				Map[x][y].type = "wall"
			else:
				Map[x][y].type = "empty"

func MakeDungeon():
	var number_rooms = randi()%4+1
	for id in range(0, number_rooms):
		var x = rand_range(2, mapsize.x-2)
		var y = rand_range(2, mapsize.y-2)
		DrunkWall(x, y, 0)

func InstantiateMap():
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			match(Map[x][y].type):
				"empty": 
					Map[x][y].Tile = tile_scene.instance()
					Map[x][y].Tile.pos = Vector2(x, y)
				"wall" : Map[x][y].Tile = tile_wall.instance()
			Map[x][y].Tile.position = Map[x][y].position
			$"../../Ground".add_child(Map[x][y].Tile)

func DrunkWall(x, y, id):
	if !IsValid(x, y) or id > 6:
		return
	
	var new_x = rand_range(-1, 1)
	var new_y = rand_range(-1, 1)
	
	Map[x][y].type = "wall"
	DrunkWall(x + new_x, y + new_y, id + 1)

func CleanGrass():
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			if Map[x][y].type == "empty":
				Map[x][y].Tile.modulate = Color.white

func IsValid(x, y):
	if x > 1 and y > 1 and x < mapsize.x-1 and y < mapsize.y-1:
		if x > mapsize.x/2 - 3 and x < mapsize.x/2 + 3:
			return false
		else:
			if y > mapsize.y/2-1 and y < mapsize.y/2+1:
				return false
			else:
				return true
	return false