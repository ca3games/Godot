extends Node2D

onready var Tile = preload("res://Scenes/Tile.tscn")
onready var tile_script = load("res://Script/Tile.gd")

var Map = []
var mapsize = Vector2(20,20)
var Player = Vector2(mapsize.x/2, 2)
var Target = Vector2(mapsize.x/2, mapsize.y-2)
var open = []
var close = []
var reverse_open = []

func _ready():
	GenerateMap()
	InstantiateMap()
	Clean()
	$Camera2D.position = Vector2(mapsize.x/2*32, mapsize.y/2*32)

func _process(delta):
	if Input.is_action_just_released("SPACE"):
		open = []
		close = []
		reverse_open = []
		MakePath(open, reverse_open, close, Player, Target, 999)
	if Input.is_action_just_released("ENTER"):
		get_tree().change_scene("res://Scenes/Map.tscn")
	
func GenerateMap():
	for x in range(0, mapsize.x):
		Map.append([])
		for y in range(0, mapsize.y):
			Map[x].append([])
			Map[x][y] = tile_script.new()

func InstantiateMap():
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			Map[x][y].Tile = Tile.instance()
			Map[x][y].Tile.position = Vector2(x*32, y*32)
			Map[x][y].Tile.pos = Vector2(x, y)
			add_child(Map[x][y].Tile)

func MakeWallPos(pos):
	Map[pos.x][pos.y].wall = !Map[pos.x][pos.y].wall
	Clean()

func MakePath(open, reverse_open, close, current, target, distance):
	if current == target or distance <= 1:
		$CanvasLayer/Label.text = "DONE"
		close.append(current)
		close.append(target)
		return
	
	AddNode(current, open, close, Vector2.ZERO)
	AddNode(current, open, close, Vector2(-1, 0))
	AddNode(current, open, close, Vector2(1, 0))
	AddNode(current, open, close, Vector2(0, 1))
	AddNode(current, open, close, Vector2(0, -1))
	
	AddNode(target, reverse_open, close, Vector2.ZERO)
	AddNode(target, reverse_open, close, Vector2(-1, 0))
	AddNode(target, reverse_open, close, Vector2(1, 0))
	AddNode(target, reverse_open, close, Vector2(0, 1))
	AddNode(target, reverse_open, close, Vector2(0, -1))
	
	close.append(current)
	close.append(target)
	
	UpdateValues(open, reverse_open, current, target)
	
	open.remove(GetID(open, current))
	reverse_open.remove(GetID(reverse_open, target))
	
	var open_small = GetSmallestNode(open)
	var reverse_small = GetSmallestNode(reverse_open)
	
	Print()
	
	Map[current.x][current.y].Tile.Print(distance)
	Map[target.x][target.y].Tile.Print(distance)
	
	var next_open = Vector2(open[open_small].x, open[open_small].y)
	var next_reverse = Vector2(reverse_open[reverse_small].x, reverse_open[reverse_small].y)
	
	Map[next_open.x][next_open.y].Tile.Colorize(Color.green)
	Map[next_reverse.x][next_reverse.y].Tile.Colorize(Color.orange)
	
	$Timer.start(0.3)
	yield($Timer, "timeout")
	
	MakePath(open, reverse_open, close, next_open, next_reverse, GetDistance(next_open, next_reverse))

func Has(list, pos):
	for i in range(0, len(list)):
		if Vector2(list[i].x, list[i].y) == pos:
			return true
	return false

func GetSmallestNode(list):
	var id = 0
	var smallest = 99999
	
	for i in range(0, len(list)):
		if smallest >= list[i].z:
			id = i
			smallest = list[i].z
	
	return id

func GetID(list, pos):
	for i in range(0, len(list)):
		if Vector2(list[i].x, list[i].y) == pos:
			return i
	return null

func AddNode(current, list, close, pos):
	if not IsValid(current + pos):
		return
	if list.has(current + pos) or close.has(current + pos):
		return
	else:
		var tmp = Vector3(current.x + pos.x, current.y + pos.y, 0)
		list.append(tmp)

func IsValid(pos):
	if pos.x >= 0 and pos.y >= 0 and pos.x < mapsize.x and pos.y < mapsize.y:
		if Map[pos.x][pos.y].wall == false:
			return true
	return false

func UpdateValues(open, reverse_open, current, target):
	for i in range(0, len(open)):
		open[i].z = GetDistance(target, Vector2(open[i].x, open[i].y))
	
	for i in range(0, len(reverse_open)):
		reverse_open[i].z = GetDistance(Vector2(reverse_open[i].x, reverse_open[i].y), current)


func GetDistance(target, current):
	return abs(current.x - target.x) + abs(current.y - target.y)


func Print():
	for id in range(0, len(open)):
		Map[open[id].x][open[id].y].Tile.Colorize(Color.lightblue)
		#Map[open[id].x][open[id].y].Tile.Print(open[id].z)
	for id in range(0, len(reverse_open)):
		Map[reverse_open[id].x][reverse_open[id].y].Tile.Colorize(Color.lightpink)
		#Map[reverse_open[id].x][reverse_open[id].y].Tile.Print(reverse_open[id].z)
	for id in range(0, len(close)):
		Map[close[id].x][close[id].y].Tile.Colorize(Color.red)


func Clean():
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			Map[x][y].Tile.HideInfo()
			if Map[x][y].wall:
				Map[x][y].Tile.Colorize(Color.black)
			else:
				Map[x][y].Tile.Colorize(Color.white)
	Map[Player.x][Player.y].Tile.Colorize(Color.red)
	Map[Target.x][Target.y].Tile.Colorize(Color.blue)