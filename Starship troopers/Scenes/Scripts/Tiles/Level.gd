extends Node

onready var Tile = preload("res://Scenes/Tiles/Ground.tscn")
onready var TileScript = load("res://Scenes/Scripts/Tiles/Tile.gd")
onready var camera = get_tree().get_root().get_node("Level/Camera")
onready var tiles_root = get_tree().get_root().get_node("Level/Tiles")

var Tiles = []
var MapSize
var MapRoom = Vector2(9,9)
var CellSize = Vector2(1,1)
var max_rooms = 5

func _ready():
	var size = MapRoom * Vector2(max_rooms, max_rooms)
	MapSize = size
	Tiles = CreateMap()
	MakeMap(Tiles)
	camera.global_transform.origin = Vector3(MapSize.x/2, 5, MapSize.y/2)

func CreateMap():
	var tile = []
	for x in range(0, MapSize.x):
		tile.append([])
		for y in range(0, MapSize.y):
			tile[x].append([])
			tile[x][y] = TileScript.new()
			tile[x][y].pos = Vector2(x, y)
			tile[x][y].position = Vector2(x*CellSize.x, y*CellSize.y)
			tile[x][y].room_id = Vector2(x/9, y/9)
	return tile

func MakeMap(tile):
	for x in range(0, MapSize.x):
		for y in range(0, MapSize.y):
			tile[x][y].tile = Tile.instance()
			tile[x][y].tile.global_transform.origin = Vector3(tile[x][y].position.x, 0, tile[x][y].position.y)
			tiles_root.add_child(tile[x][y].tile)
	ColorTile(tile)

func ColorTile(tile):
	for x in range(0, MapSize.x):
		for y in range(0, MapSize.y):
			match(tile[x][y].room_id):
				Vector2 (1,1) : 
					ColorCell(tile, Vector2(x, y), Color.blue)
				Vector2 (1,2) : 
					ColorCell(tile, Vector2(x, y), Color.brown)
				Vector2 (1,3) : 
					ColorCell(tile, Vector2(x, y), Color.green)
				Vector2 (2,1) : 
					ColorCell(tile, Vector2(x, y), Color.blueviolet)
				Vector2 (2,2) : 
					ColorCell(tile, Vector2(x, y), Color.darkgray)
				Vector2 (2,3) : 
					ColorCell(tile, Vector2(x, y), Color.aqua)
				Vector2 (3,1) : 
					ColorCell(tile, Vector2(x, y), Color.red)
				Vector2 (3,2) : 
					ColorCell(tile, Vector2(x, y), Color.orange)
				Vector2 (3,3) : 
					ColorCell(tile, Vector2(x, y), Color.yellow)
					
				
	
func ColorCell(tile, pos, color):
	tile[pos.x][pos.y].tile.ModulateColor(color)
	
func GetPosition(pos):
	return Vector3(Tiles[pos.x][pos.y].position.x, 0, Tiles[pos.x][pos.y].position.y)

func SetUnitShadow(pos):
	Tiles[pos.x][pos.y].tile.ModulateInfo(Color.brown)

func GetRandomCoord():
	var x = randi()%int(MapSize.x)+1
	var y = randi()%int(MapSize.y)+1
	return Vector2(x-1, y-1)