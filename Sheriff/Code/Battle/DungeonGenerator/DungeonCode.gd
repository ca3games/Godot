extends Node2D

var Map = []
var grasstiles = []
export(Vector2) var maxsize
var size
export(NodePath) var MapTilesPath
onready var MapTiles = get_node(MapTilesPath)
export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)
export(NodePath) var LeftUpPath
onready var LeftUp = get_node(LeftUpPath)
export(NodePath) var RightDownPath
onready var RightDown = get_node(RightDownPath)
export(int) var RockIndex
export(int) var GrassIndex
export(int) var SandIndex
onready var boundaries = Rect2(0, 0, 0, 0)

func _ready():
	randomize()
	CreateMap(5)
	Player.global_position = MapTiles.map_to_world(Vector2(size.x/2, size.y/2))
	LeftUp.global_position = MapTiles.map_to_world(Vector2(1, 1))
	RightDown.global_position = MapTiles.map_to_world(Vector2(size.x-2, size.y-2))

func CreateMap(NumberRooms):
	var pos = Vector2.ZERO
	for x in NumberRooms:
		size = Vector2(rand_range(4, maxsize.x), rand_range(4, maxsize.y))
		Map = CreateRoom(size.x, size.y)
		var array = []
		array.append(RandomWalkPath(pos.x + (size.x/2), pos.y + (size.y/2), array, 0, 50))
		SetMapTexture(pos.x,pos.y)
		pos = CreatePath(array, pos.x + (size.x/2), pos.y + (size.y/2))
	PutRockWalls()

func RandomWalkPath(x, y, array, i, maxid):
	if i > maxid:
		return array
	
	var pos = int(rand_range(1, 4))
	match(pos):
		1: RandomWalkPath(0, 1, array, i+1, maxid)
		2: RandomWalkPath(-1, 0, array, i+1, maxid)
		3: RandomWalkPath(0, -1, array, i+1, maxid)
		_: RandomWalkPath(1, 0, array, i+1, maxid)
	
	return array.append(Vector2(int(x), int(y)))
	
func CheckBoundaries(x, y):
	if x < boundaries.position.x:
		boundaries.position.x = x
	if x > boundaries.position.x + boundaries.size.x:
		boundaries.size.x = x - boundaries.position.x
	if y < boundaries.position.y:
		boundaries.position.y = y
	if y > boundaries.position.y + boundaries.size.y:
		boundaries.size.y = y - boundaries.position.y
	
func CreatePath(array, x, y):
	var pos = Vector2(x, y)
	for x in len(array):
		if x < len(array)-1:
			var new_pos = Vector2.ZERO
			new_pos.x = int(clamp(array[x].x, -1, 1))
			new_pos.y = int(clamp(array[x].y, -1, 1))
			pos += new_pos
			CarveGrassPath(pos.x, pos.y)
			grasstiles.append(Vector2(pos.x, pos.y))
	return pos

func CarveGrassPath(x, y):
	SetGrass(x-1, y)
	SetGrass(x+1, y)
	SetGrass(x-1, y-1)
	SetGrass(x+1, y-1)
	SetGrass(x+1, y+1)
	SetGrass(x-1, y+1)
	SetGrass(y, y+1)
	SetGrass(y, y-1)
	SetGrass(x, y)

func PutRockWalls():
	for x in len(grasstiles):
		Walls(grasstiles[x].x, grasstiles[x].y)
		for i in range(10):
			CarveRockPos(grasstiles[x].x, grasstiles[x].y, i)
		
func CarveRockPos(x, y, off):
	SetRock(x-off, y)
	SetRock(x+off, y)
	SetRock(x-off, y-off)
	SetRock(x+off, y-off)
	SetRock(x+off, y+off)
	SetRock(x-off, y+off)
	SetRock(y, y+off)
	SetRock(y, y-off)
	SetRock(x, y)


func Walls(x, y):
	var check = false
	if Corner(x-1, y): check = true
	if Corner(x+1, y): check = true
	if Corner(x-1, y-1): check = true
	if Corner(x+1, y-1): check = true
	if Corner(x-1, y+1): check = true
	if Corner(x+1, y+1): check = true
	if Corner(x, y+1): check = true
	if Corner(x, y-1): check = true
	if check:
		SetRock(x, y)

func Corner(x, y):
	if MapTiles.get_cell(x, y) == -1:
		return true
	return false

func SetRock(x, y):
	if MapTiles.get_cell(x, y) == -1:
		MapTiles.set_cell(x, y, RockIndex)

func SetGrass(x, y):
	MapTiles.set_cell(x, y, GrassIndex)



func CreateRoom(h, v):
	var map = []
	for x in h:
		map.append([])
		for y in v:
			map[x].append([])
			map[x][y].append(GrassIndex)
	return map

func SetMapTexture(x, y):
	SetMapTextureRoom(size.x, size.y, x, y)

func SetMapTextureRoom(h, v, xp, yp):
	for x in int(h):
		for y in int(v):
			var n = Map[x][y][0]
			MapTiles.set_cell(x+xp, y+yp, GrassIndex)
			grasstiles.append(Vector2(x+xp, y+yp))
