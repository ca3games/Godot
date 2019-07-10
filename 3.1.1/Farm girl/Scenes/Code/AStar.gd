extends Node

var offset
onready var astar = AStar.new()
onready var Cell = load("res://Scenes/Code/Cell.gd")

func FindPath(map, start, end, mapsize):
	var open = []
	var close = []
	var reverse_open = []
	var reverse_close = []
	AddCleanNode(map, open, close, Vector3(start.x, start.y, 999), start, end, mapsize, 0)
	AddReverse(map, reverse_open, reverse_close, Vector3(end.x, end.y, 999), end, start, mapsize, 0)
	PrintPath(open, close, reverse_open, reverse_close, map)


#end Vector2
#current Vector3 (x, y, cost)
func AddCleanNode(map, open, close, current, start, end, mapsize, id):
	if id > 100:
		return
	if Vector2(current.x, current.y) == end:
		return
	
	var cost_home = GetCost(Vector2(current.x, current.y), start)
	map[current.x][current.y].cost2 = cost_home
	var cost_target = GetCost(Vector2(current.x, current.y), end)
	
	var cost = cost_home + cost_target
	
	close.append(current)
	
	AddOpen(map, mapsize, open, Vector2(current.x, current.y) + Vector2(-1, 0), cost + 10)
	AddOpen(map, mapsize, open, Vector2(current.x, current.y) + Vector2(1, 0), cost + 10)
	AddOpen(map, mapsize, open, Vector2(current.x, current.y) + Vector2(0, -1), cost + 10)
	AddOpen(map, mapsize, open, Vector2(current.x, current.y) + Vector2(0, 1), cost + 10)
	
	var smallest = GetSmallOpen(open, close, end, start)
	#PrintPath(open, close, map)
	#map[smallest.x][smallest.y].Tile.PrintHelp(Color.yellow)
	#$Timer.start(1)
	#yield($Timer, "timeout")
	AddCleanNode(map, open, close, smallest, start, end, mapsize, id+1)
	
	
#end Vector2
#current Vector3 (x, y, cost)
func AddReverse(map, open, close, current, start, end, mapsize, id):
	if id > 100:
		return
	if Vector2(current.x, current.y) == end:
		return
	
	var cost_home = GetCost(Vector2(current.x, current.y), start)
	map[current.x][current.y].cost2 = cost_home
	var cost_target = GetCost(Vector2(current.x, current.y), end)
	
	var cost = cost_home + cost_target
	
	close.append(current)
	
	AddOpen(map, mapsize, open, Vector2(current.x, current.y) + Vector2(-1, 0), cost + 10)
	AddOpen(map, mapsize, open, Vector2(current.x, current.y) + Vector2(1, 0), cost + 10)
	AddOpen(map, mapsize, open, Vector2(current.x, current.y) + Vector2(0, -1), cost + 10)
	AddOpen(map, mapsize, open, Vector2(current.x, current.y) + Vector2(0, 1), cost + 10)
	
	var smallest = GetSmallReverse(open, close, start)
	#PrintPath(open, close, map)
	#map[smallest.x][smallest.y].Tile.PrintHelp(Color.green)
	#$Timer.start(1)
	#yield($Timer, "timeout")
	AddReverse(map, open, close, smallest, start, end, mapsize, id+1)

func GetSmallOpen(open, close, target, start):
	var smallest = Vector3(0, 0, 999)
	var distance = 999
	
	for id in len(open):
		if not close.has(open[id].z):
			var cost = GetCost(Vector2(open[id].x, open[id].y), target)
			var home_cost = GetCost(Vector2(open[id].x, open[id].y), start)
			if open[id].z <= smallest.z and cost <= distance:
				distance = cost
				smallest = open[id]
	return smallest

func GetSmallReverse(open, close, target):
	var smallest = Vector3(0, 0, 999)
	var home = 999
	
	for id in len(open):
		if not close.has(open[id].z):
			var home_cost = GetCost(Vector2(open[id].x, open[id].y), target)
			if open[id].z <= smallest.z and home >= home_cost:
				smallest = open[id]
				home = home_cost
	return smallest


func GetCost(current, target):
	return abs(target.x - current.x) + abs(target.y - current.y)

func AddOpen(map, mapsize, open, position, cost):
	if IsValid(map, mapsize, position):
		if not open.has(position):
			map[position.x][position.y].cost = cost
			open.append(Vector3(position.x, position.y, cost))

func IsValid(map, mapsize, pos):
	if pos.x > 0 and pos.y > 0 and pos.x < mapsize.x and pos.y < mapsize.y:
		if map[pos.x][pos.y].item == Cell.type.empty:
			return true
	return false

func PrintPath(open, close, reverse, reverse_close, map):
	for id in open:
		map[id.x][id.y].Tile.PrintHelp(Color.lightblue)
	for id in close:
		map[id.x][id.y].Tile.PrintHelp(Color.red)
	for id in reverse_close:
		map[id.x][id.y].Tile.PrintHelp(Color.lightpink)
	for id in reverse:
		map[id.x][id.y].Tile.PrintHelp(Color.greenyellow)
