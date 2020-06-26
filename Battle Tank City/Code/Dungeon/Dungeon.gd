extends Spatial

onready var tile = load("res://Code/Dungeon/Tile.gd")
onready var brick = preload("res://Scenes/Level/Brick.tscn")
onready var leaf = preload("res://Scenes/Level/Leaves.tscn")
onready var water = preload("res://Scenes/Level/Water.tscn")
onready var steel = preload("res://Scenes/Level/Steel.tscn")
onready var sand = preload("res://Scenes/Level/Sand.tscn")

onready var Player1 = preload("res://Scenes/Player/Player.tscn")
onready var Player2 = preload("res://Scenes/Player/Player 2.tscn")

onready var Eagle = preload("res://Scenes/Items/Eagle.tscn")

onready var Grenade = preload("res://Scenes/Items/Grenade.tscn")
onready var Helmet = preload("res://Scenes/Items/Helmet.tscn")
onready var Shovel = preload("res://Scenes/Items/Shovel.tscn")
onready var Star = preload("res://Scenes/Items/Star.tscn")
onready var Tank = preload("res://Scenes/Items/Tank.tscn")
onready var Time = preload("res://Scenes/Items/Timer.tscn")

onready var Enemy01 = preload("res://Scenes/Enemies/Enemy01.tscn")
onready var Enemy02 = preload("res://Scenes/Enemies/Enemy02.tscn")
onready var Enemy03 = preload("res://Scenes/Enemies/Enemy03.tscn")
onready var Enemy04 = preload("res://Scenes/Enemies/Enemy04.tscn")

var size = Vector2(35,20)
var offset = 2
var Map
var rooms = 10

var eagle_home
var eagle

func _ready():
	randomize()
	Map = CreateEmptyMap()
	SpawnWater()
	MakeSand()
	SpawnRandomSeeds()
	MakeBushes()
	MakeBricks()
	Clear()
	MakeHouse(size.x/2+1, size.y-2)
	
	SpawnTiles()
	
	eagle = Eagle.instance()
	eagle.global_transform.origin = Vector3(((size.x/2)*offset)+(offset/2), 0, (size.y-2)*offset)
	$"../Players".add_child(eagle)
	
	$"../Camera".global_transform.origin = Vector3(size.x/2*offset, 30, size.y+5*offset)
	
	var p1 = Player1.instance()
	p1.global_transform.origin = Vector3((size.x/2-2)*offset, 0.1, (size.y-2)*offset)
	$"../Players".add_child(p1)
	
	var p2 = Player2.instance()
	p2.global_transform.origin = Vector3((size.x/2+3)*offset, 0.1, (size.y-2)*offset)
	$"../Players".add_child(p2)
	
	$"../Ground".global_transform.origin = Vector3((size.x/2)*offset, -1, (size.y/2)*offset)

func SpawnEnemy():
	var x = randi()% int(size.x-4) + 2
	var y = randi()%2 + 1
	if Map[x][y].cell_type == tile.cell.empty or Map[x][y].cell_type == tile.cell.sand or Map[x][y].cell_type == tile.cell.bush:
		var tmp
		var tank = randi()%6+1
		
		match(tank):
			1: tmp = Enemy01.instance()
			2: tmp = Enemy02.instance()
			3: tmp = Enemy03.instance()
			4: tmp = Enemy04.instance()
			_: tmp = Enemy01.instance()
		tmp.global_transform.origin = Vector3(x*offset, 0, y*offset)
		tmp.get_node("Move").home = eagle.global_transform.origin
		$"../Players".add_child(tmp)
	else:
		SpawnEnemy()

func SpawnItem():
	var x = randi()% int(size.x-4) + 2
	var y = randi()% int(size.y-4) + 2
	if Map[x][y].cell_type != tile.cell.water:
		match(randi()%6+1):
			1:
				var tmp = Grenade.instance()
				tmp.global_transform.origin = Vector3(x * offset + (offset/2), 0.5, y * offset)
				$"../Players".add_child(tmp)
			2:
				var tmp = Helmet.instance()
				tmp.global_transform.origin = Vector3(x * offset + (offset/2), 0.5, y * offset)
				$"../Players".add_child(tmp)
			3:
				var tmp = Shovel.instance()
				tmp.global_transform.origin = Vector3(x * offset + (offset/2), 0.5, y * offset)
				$"../Players".add_child(tmp)
			4:
				var tmp = Star.instance()
				tmp.global_transform.origin = Vector3(x * offset + (offset/2), 0.5, y * offset)
				$"../Players".add_child(tmp)
			5:
				var tmp = Tank.instance()
				tmp.global_transform.origin = Vector3(x * offset + (offset/2), 0.5, y * offset)
				$"../Players".add_child(tmp)
			6:
				var tmp = Time.instance()
				tmp.global_transform.origin = Vector3(x * offset + (offset/2), 0.5, y * offset)
				$"../Players".add_child(tmp)
	else:
		SpawnItem()


func CreateEmptyMap():
	var map = []
	for x in size.x:
		map.append([])
		for y in size.y:
			map[x].append([])
			map[x][y] = tile.new()
			map[x][y].pos = Vector2(x, y)
			if x == 0 or y == 0 or x == size.x-1 or y == size.y-1:
				map[x][y].cell_type = tile.cell.water
	return map

func SpawnRandomSeeds():
	for i in rooms:
		var x = rand_range(1, size.x-2)
		var y = rand_range(1, size.y-2)
		Map[x][y].cell_type = tile.cell.steel

func MakeHouse(x, y):
	SetBrick(x-1, y)
	SetBrick(x+1, y)
	SetBrick(x, y-1)
	SetBrick(x-1, y-1)
	SetBrick(x+1, y-1)

func SetBrick(x, y):
	Map[x][y].cell_type = tile.cell.brick

func MakeSand():
	for i in 5:
		randomize()
		var x = rand_range(1, size.x-2)
		var y = rand_range(1, size.y-2)
		MakeSandIsland(x, y, 0)

func MakeSandIsland(x, y, id):
	if id >= 5:
		return
	if !IsValid(x, y):
		return
	if rand_range(1, 10) > 7:
		return
	
	Map[x][y].cell_type = tile.cell.sand
	MakeSandIsland(x-1, y, id+1)
	MakeSandIsland(x+1, y, id+1)
	MakeSandIsland(x, y-1, id+1)
	MakeSandIsland(x, y+1, id+1)

func MakeBushes():
	for i in 10:
		randomize()
		var x = rand_range(1, size.x-2)
		var y = rand_range(1, size.y-2)
		MakeBushIsland(x, y, 0)

func MakeBushIsland(x, y, id):
	if id > 5:
		return
	if !IsValid(x, y):
		return
	
	Map[x][y].cell_type = tile.cell.bush
	var tmp = rand_range(0, 8)
	match(int(tmp)):
		1: MakeBushIsland(x-1, y-1, id+1)
		2: MakeBushIsland(x, y-1, id+1)
		3: MakeBushIsland(x+1, y-1, id+1)
		4: MakeBushIsland(x-1, y, id+1)
		5: MakeBushIsland(x+1, y, id+1)
		6: MakeBushIsland(x-1, y+1, id+1)
		7: MakeBushIsland(x, y+1, id+1)
		8: MakeBushIsland(x+1, y+1, id+1)
		_: MakeBushIsland(x+1, y, id+1)

func MakeBricks():
	for x in size.x:
		for y in size.y:
			if x % 5 == 0 or y % 5 == 0:
				if Map[x][y].cell_type == 0:
					if rand_range(0, 10) < 3:
						Map[x][y].cell_type = tile.cell.brick
			if x % 4 == 0 or y % 4 == 0:
				if Map[x][y].cell_type == 0:
					if rand_range(0, 10) < 3:
						Map[x][y].cell_type = tile.cell.brick
			if x % 3 == 0 or y % 3 == 0:
				if Map[x][y].cell_type == 0:
					if rand_range(0, 10) < 1:
						Map[x][y].cell_type = tile.cell.brick

func SpawnWater():
	for i in 5:
		var x = rand_range(2, size.x-2)
		var y = rand_range(2, size.y-2)
		WaterCell(x, y, 0)

func WaterCell(x, y, id):
	if id > 4:
		return
	if !IsValid(x, y):
		return
	if rand_range(0, 10) < 5:
		return
	
	Map[x][y].cell_type = tile.cell.water
	
	if rand_range(1, 10) < 4:
		WaterCell(x-1, y, id+1)
		WaterCell(x+1, y, id+1)
		WaterCell(x, y-1, id+1)
		WaterCell(x, y+1, id+1)
	else:
		match(int(rand_range(0, 4))):
			1: WaterCell(x-1, y, id+1)
			2: WaterCell(x+1, y, id+1)
			3: WaterCell(x, y-1, id+1)
			4: WaterCell(x, y+1, id+1)

func SpawnTiles():
	for x in size.x:
		for y in size.y:
			match(Map[x][y].cell_type):
				tile.cell.steel: 
					var tmp = steel.instance()
					tmp.global_transform.origin = Vector3(x*offset, 0, y*offset)
					$"../Tiles".add_child(tmp)
				tile.cell.sand:
					var tmp = sand.instance()
					tmp.global_transform.origin = Vector3(x*offset, -1, y*offset)
					tmp.rotate_x(-80)
					$"../Tiles".add_child(tmp)
				tile.cell.bush:
					var tmp = leaf.instance()
					tmp.global_transform.origin = Vector3(x*offset, 0, y*offset)
					$"../Tiles".add_child(tmp)
				tile.cell.brick:
					var tmp = brick.instance()
					tmp.global_transform.origin = Vector3(x*offset, 0, y*offset)
					$"../Tiles".add_child(tmp)
				tile.cell.water:
					var tmp = water.instance()
					tmp.global_transform.origin = Vector3(x*offset, 0, y*offset)
					$"../Tiles".add_child(tmp)


func IsValid(x, y):
	if x < 1 or x >= size.x-1 or y < 1 or y >= size.y-1:
		return false
	return true
	
func Clear():
	for x in 12:
		for y in 4:
			var h = int((size.x / 2) - 6 + x)
			var v = (size.y-5) + y
			Map[h][v].cell_type = 0


func _on_Timer_timeout():
	$"../Timer".start(5)
	SpawnEnemy()
