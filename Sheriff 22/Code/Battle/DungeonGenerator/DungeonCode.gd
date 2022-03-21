extends Node2D

export(int) var tumbleweedmax
export(int) var basicenemymax
export(int) var basicbossmax

export(Vector2) var origin
export(int) var NumberRooms
export(Vector2) var MaxRoomSize
export(Rect2) var DungeonSize
export(int) var GrassIndex
export(int) var RockIndex
export(int) var PathIndex

export(NodePath) var TileMapPath
onready var tilemap = get_node(TileMapPath)
export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

export(NodePath) var EnemyManagerPath
onready var EnemyManager = get_node(EnemyManagerPath)

onready var RoomTiles = []
onready var RoomCenters = []
onready var RoomWalls = []
onready var Paths = []
onready var EnemySpawn = []
onready var SpawnedPicked = []

export(PackedScene) var BasicEnemy
export(PackedScene) var BasicBoss
export(PackedScene) var tumbleweed01

func _ready():
	randomize()
	NumberRooms = Variables.level + 1
	basicbossmax = int(Variables.level / 5)
	basicenemymax = Variables.level + 3
	yield(get_tree(), "idle_frame")
	CreateMap()
	SpawnTiles()
	tilemap.update_bitmask_region(DungeonSize.position, DungeonSize.size)
	Player.global_position = tilemap.map_to_world(RoomCenters[0])
	SpawnedPicked.append(RoomCenters[0])
	SpawnEnemies()
	SpawnTumbleweeds()
	SpawnedPicked.remove(0)
	SummonEnemies()
	
func CreateMap():
	for x in NumberRooms:
		var pos = Vector2(rand_range(DungeonSize.position.x, DungeonSize.position.x + DungeonSize.size.x), rand_range(DungeonSize.position.y, DungeonSize.position.y + DungeonSize.size.y))
		var size = Vector2(rand_range(4, MaxRoomSize.x), rand_range(4, MaxRoomSize.y))
		SetRoom(size, pos, x)
	for i in len(RoomCenters):
		if i > 0 or i < len(RoomCenters)-1:
			var pat = []
			pat.append(RandomWalk(RoomCenters[i-1], RoomCenters[i], 0, []))
			for x in pat:
				Paths.append(x)

func SpawnEnemies():
	for i in NumberRooms:
		if i > 0:
			SpawnBasicEnemyRoom(i)
		
func SpawnBosses():
	for i in 3:
		AddSpawnLocation(NumberRooms - i - 1)

func SpawnTumbleweeds():
	for i in tumbleweedmax:
		var chance = randi()%3 +1
		if chance == 2:
			Tumbleweed()


func SpawnBasicEnemyRoom(room):
	for i in basicenemymax:
		AddSpawnLocation(room)

func SummonEnemies():
	for i in len(SpawnedPicked):
		if i < len(SpawnedPicked)-basicbossmax:
			SpawnEnemy("BASIC", SpawnedPicked[i])
		else:
			SpawnEnemy("BOSS", SpawnedPicked[i])

func Tumbleweed():
	for x in Paths:
		var id = len(x)
		var pos = Vector2.ZERO
		var y = int(rand_range(1, id-1))
		pos = x[y]
		var mapos = tilemap.map_to_world(pos)
		EnemyManager.SpawnPlant(mapos.x, mapos.y, tumbleweed01)



func SpawnLocation(room, i):
	if i > 800:
		return 1
	var id = len(EnemySpawn[room])
	var x = int(rand_range(1, id))
	for y in SpawnedPicked:
		if y == EnemySpawn[room][x]:
			x = SpawnLocation(room, i+1)
	return x
	
func AddSpawnLocation(room):
	if room == 0:
		return
	SpawnedPicked.append(EnemySpawn[room][SpawnLocation(room, 0)])
	
func SpawnEnemy(id, pos):
	var mapos = tilemap.map_to_world(pos)
	match(id):
		"BASIC" : EnemyManager.SpawnEnemy(mapos.x, mapos.y, BasicEnemy)
		"BOSS" : EnemyManager.SpawnEnemy(mapos.x, mapos.y, BasicBoss, true)

func SpawnTiles():
	for x in len(RoomTiles):
		tilemap.set_cell(RoomTiles[x].x, RoomTiles[x].y, GrassIndex)
	for y in len(RoomWalls):
		SetWall(RoomWalls[y].x, RoomWalls[y].y)
	for x in Paths:
		for y in x:
			tilemap.set_cell(y.x, y.y, PathIndex)
			SetWall(y.x, y.y)

func SetWall(x, y):
	SetRock(x-1, y)
	SetRock(x+1, y)
	SetRock(x, y-1)
	SetRock(x, y+1)
	SetRock(x-1, y-1)
	SetRock(x-1, y+1)
	SetRock(x+1, y-1)
	SetRock(x+1, y+1)
	SetRock(x-2, y)
	SetRock(x+2, y)
	SetRock(x, y-2)
	SetRock(x, y+2)
	SetRock(x-2, y-2)
	SetRock(x-2, y+2)
	SetRock(x+2, y-2)
	SetRock(x+2, y+2)

func SetRock(x, y):
	if tilemap.get_cell(x, y) == -1:
		tilemap.set_cell(x, y, RockIndex)

func RandomWalk(current, goal, i, array):
	if Vector2(int(current.x), int(current.y)) == Vector2(int(goal.x), int(goal.y)) or i > 500:
		return
	array.append(current)
	
	
	var angle = (goal - current).normalized()
	var dist = angle.x + angle.y
	var dir = Vector2.ZERO
	var left = false
	var right = false
	var down = false
	var up = false
	if angle.x < 0:
		left = true
	if angle.x > 0:
		right = true
	if angle.y < 0:
		up = true
	if angle.y > 0:
		down = true
	
	if randi()%4+1 < 3:
		if randi()%4+1 > 2:
			if left:
				RandomWalk(current + Vector2.LEFT, goal, i+1, array)
			if right:
				RandomWalk(current + Vector2.RIGHT, goal, i+1, array)
		else:
			if up:
				RandomWalk(current + Vector2.UP, goal, i+1, array)
			if down:
				RandomWalk(current + Vector2.DOWN, goal, i+1, array)
	else:
		match(randi()%4+1):
			1 : RandomWalk(current + Vector2.LEFT, goal, i+1, array)
			2 : RandomWalk(current + Vector2.RIGHT, goal, i+1, array)
			3 : RandomWalk(current + Vector2.UP, goal, i+1, array)
			_: RandomWalk(current + Vector2.DOWN, goal, i+1, array)
		
	return array
	
	
	

func SetRoom(size, pos, roomid):
	EnemySpawn.append([])
	var walls = []
	for x in int(size.x):
		for y in int(size.y):
			var newpos = Vector2(int(pos.x+x - (size.x/2)), int(pos.y+y - (size.y/2)))
			if y == 0 or x == 0 or x > size.x-2 or y > size.y-2:
				walls.append(newpos)
			if y > 0 and y < size.y-2 and x > 0 and x < size.x-2:
				EnemySpawn[roomid].append(newpos)
			RoomTiles.append(newpos)
	for x in walls:
		RoomWalls.append(x)
	RoomCenters.append(Vector2(pos.x, pos.y))
