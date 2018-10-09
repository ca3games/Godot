extends Spatial

onready var TweenNode = $Tween
onready var Tile = preload("res://Scenes/Tiles/Tile.tscn")
onready var Wall = preload("res://Scenes/Tiles/Wall.tscn")
onready var Player = preload("res://Scenes/Tiles/Player.tscn")
enum cell {empty, wall}
var Tiles = []

var Map
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
	Map = []
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
			if x == 0 or y == 0 or x == size.x - 1 or y == size.y -1:
				Tile[x].append(cell.wall)
			else:
				Tile[x].append(cell.empty)
	return Tile

func _makeMap():
	for x in range(size.x):
		Map.append([])
		for y in range(size.y):
			var t
			
			match (Tiles[x][y]):
				cell.empty:
					t = Tile.instance()
				cell.wall:
					t = Wall.instance()
			t.x = x
			t.y = y
			Map[x].append(t)
			Map[x][y].global_transform.origin = Vector3(x*offset, 0, y*-1*offset)
			
			get_node("Mapa").add_child(Map[x][y])

func _getPlayerpos():
	return Map[Playerpos.x][Playerpos.y].global_transform.origin

func _getPlayerCoord():
	return Playerpos
	
func _getPos(x, y):
	return Map[x][y].global_transform.origin
	
func _turnRed(x, y):
	Map[x][y]._red()

func _turnWhite(x, y):
	Map[x][y]._white()

func _Valid(x, y):
	if x < 0 or y < 0 or x > size.x -1 or y > size.y -1:
		return false
	if Tiles[x][y] == cell.empty:
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
	var new_pos = Vector3(Map[tmp.x][tmp.y].global_transform.origin.x, 7, Map[tmp.x][tmp.y].global_transform.origin.z + 5)
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
