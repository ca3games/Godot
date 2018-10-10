extends Spatial

onready var TweenNode = $Tween
onready var Tile = preload("res://Scenes/Tiles/Tile.tscn")
onready var Wall = preload("res://Scenes/Tiles/Wall.tscn")
onready var Player = preload("res://Scenes/Tiles/Player.tscn")
onready var Minor_Wall = preload("res://Scenes/Tiles/Minor_wall.tscn")
var Tiles = []
var Cell = load("res://Code/Tiles/Cell.gd")
onready var TextManager = get_node("../../../Text")

var room_size = Vector2(9,9)
var size = Vector2(room_size.x*10,room_size.y*5)
var offset = 0.6
var camera_pos = Vector3(-1,7,5)
var camera_size = Vector2(2,2)
var camera_coord

var Playerpos = Vector2(size.x/2-1, 5)

func _ready():
	get_node("Camera").global_transform.origin = camera_pos
	camera_coord = Playerpos
	
	Tiles = _makeTiles()
	_roomWalls()
	_beginWalks()
	_beginWalksGrass()
	
	_makeWalls()
	_makeMap()
	
	var p = Player.instance()
	get_node("Mapa").add_child(p)
	p.global_transform.origin = Vector3(Playerpos.x * offset, 0, Playerpos.y *-1 * offset)
	
	var camerapos = Vector3(Playerpos.x * offset, camera_pos.y, Playerpos.y *-1 * offset + camera_pos.z)
	get_node("Camera").global_transform.origin = camerapos
	_cameramove(0,0)

func _makeTiles():
	var Tile = []
	for x in range(size.x):
		Tile.append([])
		for y in range(size.y):
			Tile[x].append([])
			Tile[x][y] = Cell.new()
			Tile[x][y].pos = Vector2(x, y)
			Tile[x][y].tipo = Cell.type.empty
	return Tile
	
func _makeWalls():
	for x in range(size.x):
		Tiles[x][0].tipo = Cell.type.wall
		Tiles[x][size.y-1].tipo = Cell.type.wall
	for y in range(size.y):
		Tiles[0][y].tipo = Cell.type.wall
		Tiles[size.x-1][y].tipo = Cell.type.wall

func _beginWalks():
	for x in range(size.x):
		for y in range(size.y):
			if Tiles[x][y].tipo == Cell.type.minor_wall:
				_drunkWalk(x-1, y, 0)
				_drunkWalk(x+1, y, 0)
				_drunkWalk(x, y-1, 0)
				_drunkWalk(x, y+1, 0)

func _drunkWalk(x, y, id):
	if id > 3:
		return
	else:
		var chance = randi()%5 + 1
		if chance == 2:
			if _Valid(x, y):
				Tiles[x][y].tipo = Cell.type.minor_wall
				_drunkWalk(x-1, y, id+1)
				_drunkWalk(x+1, y, id+1)
				_drunkWalk(x, y-1, id+1)
				_drunkWalk(x, y+1, id+1)


func _beginWalksGrass():
	for x in range(size.x):
		for y in range(size.y):
			if Tiles[x][y].tipo == Cell.type.minor_wall:
				_drunkWalkGrass(x-1, y, 0)
				_drunkWalkGrass(x+1, y, 0)
				_drunkWalkGrass(x, y-1, 0)
				_drunkWalkGrass(x, y+1, 0)

func _drunkWalkGrass(x, y, id):
	if id > 3:
		return
	else:
		var chance = randi()%5 + 1
		if chance == 2:
			if _Valid(x, y):
				Tiles[x][y].grass = true
				_drunkWalkGrass(x-1, y, id+1)
				_drunkWalkGrass(x+1, y, id+1)
				_drunkWalkGrass(x, y-1, id+1)
				_drunkWalkGrass(x, y+1, id+1)

func _roomWalls():
	var id = 0
	for xrooms in range(size.x / room_size.x):
		for yrooms in range(size.y / room_size.y):
			id += 1
			for x in range(room_size.x):
				for y in range(room_size.y):
					if x == 0 or x == room_size.x or y == 0 or y == room_size.y:
						var chance = randi()%4 + 1
						if chance == 2:
							Tiles[room_size.x * xrooms + x][room_size.y * yrooms + y].tipo = Cell.type.minor_wall
						Tiles[room_size.x * xrooms + x][room_size.y * yrooms + y].room = id

func _makeMap():
	for x in range(size.x):
		for y in range(size.y):
			var t
			
			match(Tiles[x][y].tipo):
				Cell.type.wall:
					t = Wall.instance()
				Cell.type.empty:
					t = Tile.instance()	
				Cell.type.minor_wall:
					t = Minor_Wall.instance()
				
			var tmp = Vector3(x*offset, 0, y*-1*offset)
			t.global_transform.origin = tmp
			Tiles[x][y].global_pos = tmp
			Tiles[x][y].object = t
			get_node("Mapa").add_child(Tiles[x][y].object)
			if Tiles[x][y].tipo == Cell.type.empty and Tiles[x][y].grass:
				Tiles[x][y].object._addgrass()

func _getPlayerpos():
	return Tiles[Playerpos.x][Playerpos.y].global_pos

func _getPlayerCoord():
	return Playerpos
	
func _getPos(x, y):
	return Tiles[x][y].global_pos
	
func _turnRed(x, y):
	Tiles[x][y].object._red()

func _turnWhite(x, y):
	Tiles[x][y].object._white()

func _Valid(x, y):
	if x < 0 or y < 0 or x > size.x -1 or y > size.y -1:
		return false
	if Tiles[x][y].tipo == Cell.type.empty:
		return true
	else:
		return false
		
func _moveplayer(x, y):
	Playerpos.x += x
	Playerpos.y += y

func _cameramove(x, y):
	var tmp = Vector2(0,0)
	if camera_coord.x + x < 0:
		tmp.x = 0
	elif camera_coord.x + x > size.x - 1:
		tmp.x = size.x - 1
	else:
		tmp.x = camera_coord.x + x
	if camera_coord.y + y < 0:
		tmp.y = 0
	elif camera_coord.y + y > size.y - 1:
		tmp.y = size.y - 1
	else:
		tmp.y = camera_coord.y + y
	var new_pos = Vector3(Tiles[tmp.x][tmp.y].global_pos.x, 7, Tiles[tmp.x][tmp.y].global_pos.z + 5)
	TweenNode.interpolate_property($Camera, "translation", $Camera.global_transform.origin, new_pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	TweenNode.start()

func _cameraboundary():
	if Playerpos.x < camera_coord.x - camera_size.x:
		_cameramove(-3, 0)
		camera_coord.x -= 3
	if Playerpos.x > camera_coord.x + camera_size.x:
		_cameramove(3, 0)
		camera_coord.x += 3
	if Playerpos.y < camera_coord.y + camera_size.y:
		_cameramove(-3, 0)
		camera_coord.y -= 3
	if Playerpos.y > camera_coord.y + (camera_size.y * 2):
		_cameramove(3, 0)
		camera_coord.y += 3

func _IsWall(x, y):
	if Tiles[x][y].tipo == Cell.type.minor_wall or Tiles[x][y].tipo == Cell.type.wall:
		return true
	else:
		return false

func _TextWall(direccion):
	TextManager._Wall(direccion)
	
func _GroundInfo(x, y):
	match(Tiles[x][y].tipo):
		Cell.type.empty:
			if Tiles[x][y].grass:
				TextManager._groundinfo("plant")
			else:
				TextManager._groundinfo("empty")
