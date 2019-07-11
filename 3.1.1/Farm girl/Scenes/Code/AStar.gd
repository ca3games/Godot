extends Node

var offset
onready var astar = AStar.new()
onready var Cell = load("res://Scenes/Code/Cell.gd")
var open
var close
var mapsize


func getNext(number):
	return close[number]

func FindPath(map, start, end, size):
	open = []
	close = []
	mapsize = size
	Astar(map, open, close, start, end)
	PrintPath(open, close, map)
	
func Astar(map, open, close, current, end):
	if current == end:
		return
	
	AddNode(map, open, close, end, current)
	AddNode(map, open, close, end, current + Vector2(-1, 0))
	AddNode(map, open, close, end, current + Vector2(1, 0))
	AddNode(map, open, close, end, current + Vector2(0, -1))
	AddNode(map, open, close, end, current + Vector2(0, 1))
	
	var smallest = PickSmallest(open)
	var id_open = GetID(open, current)
	
	close.append(current)
	if id_open != null:
		open.remove(id_open)
	
	Astar(map, open, close, Vector2(smallest.x, smallest.y), end)
	

func PickSmallest (open):
	var small = Vector3(0, 0, 999)
	
	for i in range(0, len(open)):
		if open[i].z <= small.z:
			small = open[i]
	
	return small

func GetID(list, pos):
	for i in range(0, len(list)):
		if Vector2(list[i].x, list[i].y) == pos:
			return i

func AddNode(map, open, close, target, pos):
	if not IsValid(map,pos):
		return
	if close.has(pos):
		return
	if not Has(open, pos):
		open.append(Vector3(pos.x, pos.y, GetDistance(target, pos)))

func Has(list, pos):
	for i in range(0, len(list)):
		if Vector2(list[i].x, list[i].y) == pos:
			return true
	return false

func GetDistance(current, target):
	return abs(target.x - current.x) + abs(target.y - current.y)

func IsValid(map, pos):
	if pos.x > 0 and pos.y > 0 and pos.x < mapsize.x and pos.y < mapsize.y:
		if map[pos.x][pos.y].item == Cell.type.empty:
			return true
	return false

func PrintPath(open, close, map):
	for id in open:
		map[id.x][id.y].Tile.PrintHelp(Color.lightblue)
	for id in close:
		map[id.x][id.y].Tile.PrintHelp(Color.red)