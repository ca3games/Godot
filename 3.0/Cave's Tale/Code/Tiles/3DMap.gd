extends Spatial

onready var Tile = preload("res://Scenes/Tiles/Tile.tscn")
onready var Tree01 = preload("res://Scenes/Props/Tree3D.tscn")
onready var Player = preload("res://Scenes/Tiles/Pacifica.tscn")
enum cell {empty, wall}
var Tiles = []

var Map
var size = Vector2(30,30)
var offset = 0.6
var camera_pos = Vector3(-1,7,11)

var Playerpos = Vector2(size.x/2-1, 5)

func _ready():
	get_node("Camera").global_transform.origin = camera_pos
	
	Tiles = []
	for x in range(size.x):
		Tiles.append([])
		for y in range(size.y):
			if x == 0 or y == 0 or x == size.x - 1 or y == size.y -1:
				Tiles[x].append(cell.wall)
			else:
				Tiles[x].append(cell.empty)
	
	Map = []
	
	for x in range(size.x):
		Map.append([])
		for y in range(size.y):
			var t
			
			match (Tiles[x][y]):
				cell.empty:
					t = Tile.instance()
				cell.wall:
					t = Tree01.instance()
			t.global_transform.origin = Vector3(x*offset, 0, y*-1*offset)
			t.x = x
			t.y = y
			Map[x].append(t)
			
			get_node("Mapa").add_child(Map[x][y])
	
	var p = Player.instance()
	p.global_transform.origin = Vector3(Playerpos.x * offset, 0, Playerpos.y *-1 * offset)
	get_node("Mapa").add_child(p)

