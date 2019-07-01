extends Node2D

onready var Tile = load("res://Code/Cell.gd")
onready var TileCell = preload("res://Scenes/Tile.tscn")
onready var Root = get_tree().get_root().get_node("Map")

func MakeMap(mapsize, offset):
	var map = []
	for x in range(0, mapsize.x):
		map.append([])
		for y in range(0, mapsize.y):
			map[x].append([])
			map[x][y] = Tile.new()
			map[x][y].pos = Vector2(x, y)
			map[x][y].position = Vector2(x*offset, y*offset)
			map[x][y].wall = false
			map[x][y].HP = 10
			map[x][y].checked = false
	return map

func MakeDungeon(Map, Playerpos, Doorpos, mapsize):
	for i in range(0, 5):
		DrunkWall(Playerpos, Doorpos, Map, mapsize, 0)
	CostDistance(Map, mapsize, Playerpos)
	PathFinding(Map, Doorpos, Playerpos, mapsize, 0)
	CostDistanceHP(Map, mapsize, Playerpos)
	PathFindingHero(Map, Playerpos, Doorpos, mapsize)

func CostPathfinding(Map, mapsize, Playerpos):
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			if !Map[x][y].wall:
				Map[x][y].cost = abs(Playerpos.x - x) + abs(Playerpos.y - y)
			else:
				Map[x][y].cost = 999
			Map[x][y].Tile.Info(str(Map[x][y].cost))

func PathFindingHero(Map, Playerpos, Doorpos, mapsize):
	if Playerpos == Doorpos or Map[Playerpos.x][Playerpos.y].HP == -100:
		return
	else:
		var direction = 5
		var left = 999
		if IsValid(Vector2(Playerpos.x-1, Playerpos.y), mapsize):
			if !Map[Playerpos.x-1][Playerpos.y].checked:
				left = Map[Playerpos.x-1][Playerpos.y].HP
		var right = 999
		if IsValid(Vector2(Playerpos.x+1, Playerpos.y), mapsize):
			if !Map[Playerpos.x+1][Playerpos.y].checked:
				left = Map[Playerpos.x+1][Playerpos.y].HP
		var up = 999
		if IsValid(Vector2(Playerpos.x, Playerpos.y-1), mapsize):
			if !Map[Playerpos.x][Playerpos.y-1].checked:
				up = Map[Playerpos.x][Playerpos.y-1].HP
		var down = 999
		if IsValid(Vector2(Playerpos.x, Playerpos.y+1), mapsize):
			if !Map[Playerpos.x][Playerpos.y+1].checked:
				down = Map[Playerpos.x][Playerpos.y+1].HP
		
		if left < right and left < up and left < down:
			direction = 4
		if right < left and right < up and right < down:
			direction = 6
		if up < left and up < right and up < down:
			direction = 8
		if down < left and down < right and down < up:
			direction = 2
		
		Map[Playerpos.x][Playerpos.y].checked = true
		Map[Playerpos.x][Playerpos.y].HP = -50
		
		match(direction):
			4 : PathFindingHero(Map, Vector2(Playerpos.x-1, Playerpos.y), Doorpos, mapsize)
			6 : PathFindingHero(Map, Vector2(Playerpos.x+1, Playerpos.y), Doorpos, mapsize)
			8 : PathFindingHero(Map, Vector2(Playerpos.x, Playerpos.y-1), Doorpos, mapsize)
			2 : PathFindingHero(Map, Vector2(Playerpos.x, Playerpos.y+1), Doorpos, mapsize)

func PathFinding(Map, Doorpos, Playerpos, mapsize, id):
	if Doorpos == Playerpos or id > 1000:
		return
	else:
		var direction = 5
		var left = 999
		if IsValid(Vector2(Doorpos.x-1, Doorpos.y), mapsize):
			if !Map[int(Doorpos.x-1)][int(Doorpos.y)].checked:
				left = Map[int(Doorpos.x-1)][int(Doorpos.y)].cost
		var right = 999 
		if IsValid(Vector2(Doorpos.x+1, Doorpos.y), mapsize):
			if !Map[int(Doorpos.x+1)][int(Doorpos.y)].checked:
				right = Map[int(Doorpos.x+1)][int(Doorpos.y)].cost
		var up = 999 
		if IsValid(Vector2(Doorpos.x, Doorpos.y-1), mapsize):
			if !Map[int(Doorpos.x)][int(Doorpos.y-1)].checked:
				up = Map[int(Doorpos.x)][int(Doorpos.y-1)].cost
		var down = 999 
		if IsValid(Vector2(Doorpos.x, Doorpos.y+1), mapsize):
			if !Map[int(Doorpos.x)][int(Doorpos.y+1)].checked:
				down = Map[int(Doorpos.x)][int(Doorpos.y+1)].cost
		
		if left < right and left < up and left < down:
			direction = 4
		if right < left and right < up and right < down:
			direction = 6
		if up < left and up < right and up < down:
			direction = 8
		if down < left and down < right and down < up:
			direction = 2
		
		Map[Doorpos.x][Doorpos.y].checked = true
		Map[Doorpos.x][Doorpos.y].HP = -100
		
		match(direction):
			4 : PathFinding(Map, Vector2(Doorpos.x-1, Doorpos.y), Playerpos, mapsize, id+1)
			6 : PathFinding(Map, Vector2(Doorpos.x+1, Doorpos.y), Playerpos, mapsize, id+1)
			8 : PathFinding(Map, Vector2(Doorpos.x, Doorpos.y-1), Playerpos, mapsize, id+1)
			2 : PathFinding(Map, Vector2(Doorpos.x, Doorpos.y+1), Playerpos, mapsize, id+1)
			5 : 
				var left_h = true if Doorpos.x-1 < mapsize.x / 2 else false
				var right_h = true if Doorpos.x+1 > mapsize.x / 2 else false
				if left_h and Doorpos.x-1 > 0 and Doorpos.x-1 < mapsize.x-1:
					if Doorpos.y < mapsize.y - 2:
						PathFinding(Map, Vector2(Doorpos.x, Doorpos.y+1), Playerpos, mapsize, id+1)
					else:
						PathFinding(Map, Vector2(Doorpos.x-1, Doorpos.y), Playerpos, mapsize, id+1)
				elif right_h and Doorpos.x+1 < mapsize.x-1 and Doorpos.x+1 > 0:
					if Doorpos.y < mapsize.y - 2:
						PathFinding(Map, Vector2(Doorpos.x, Doorpos.y+1), Playerpos, mapsize, id+1)
					else:
						PathFinding(Map, Vector2(Doorpos.x+1, Doorpos.y), Playerpos, mapsize, id+1)
				else:
					if Doorpos.y+1 < mapsize.y -2:
						PathFinding(Map, Vector2(Doorpos.x, Doorpos.y+1), Playerpos, mapsize, id+1)
					if Doorpos.y+1 == mapsize.y -1:
						if left_h:
							PathFinding(Map, Vector2(Doorpos.x+1, Doorpos.y), Playerpos, mapsize, id+1)
						if right_h:
							PathFinding(Map, Vector2(Doorpos.x-1, Doorpos.y), Playerpos, mapsize, id+1)
					if Doorpos.y > mapsize.y -1:
						PathFinding(Map, Vector2(Doorpos.x, Doorpos.y-1), Playerpos, mapsize, id+1)

func CostDistance(Map, mapsize, playerpos):
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			var score = ScorePos(Map, Vector2(x, y), playerpos, mapsize)
			Map[x][y].cost = score

func CostDistanceHP(Map, mapsize, playerpos):
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			Map[x][y].HP += Map[x][y].cost

func ScorePos(Map, doorpos, playerpos, mapsize):
	var score = 0
	var distance = (doorpos.x - playerpos.x) + (doorpos.y - playerpos.y)
	score += distance
	var HP = Map[doorpos.x][doorpos.y].HP
	score += HP
	return score

func DrunkWall(currentpos, doorpos, Map, mapsize, id):
	if currentpos == doorpos or id > 300:
		return
	else:
		var cycle = true
		var new_pos = Vector2(0, 0)
		while(cycle):
			new_pos = PickDirection()
			if IsValid(currentpos + new_pos, mapsize):
				Map[int(currentpos.x + new_pos.x)][int(currentpos.y + new_pos.y)].HP -= 1
				break
		DrunkWall(currentpos + new_pos, doorpos, Map, mapsize, id + 1)

func PickDirection():
	randomize()
	var direction = randi()%4 + 1
	var new_pos = Vector2(0, 0)
	match(direction):
		1 : new_pos = Vector2(0, -1)
		2 : new_pos = Vector2(1, 0)
		3 : new_pos = Vector2(0, 1)
		4 : new_pos = Vector2(-1, 0)
	return new_pos

func IsValid(pos, mapsize):
	if pos.x > 0 and pos.x < mapsize.x-1 and pos.y > 0 and pos.y < mapsize.y-1:
		return true
	return false

func IsEmpty(Map, pos, mapsize):
	if pos.x > 0 and pos.x < mapsize.x-1 and pos.y > 0 and pos.y < mapsize.y-1:
		if !Map[pos.x][pos.y].wall:
			return true
	return false

func ResetMap(Map, mapsize):
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			Map[x][y].Tile.Transparency(Map[x][y].HP)

func InstantiateMap(Map, mapsize):
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			$"../../TileMap".set_cell(x, y, 0)
			if Map[x][y].HP > 2.5:
				Map[x][y].wall = true
				$"../../TileMap".set_cell(x, y, 1)