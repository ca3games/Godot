extends Node2D

export(Vector2) var origin
export(int) var NumberRooms
export(Vector2) var MaxRoomSize
export(Rect2) var DungeonSize
export(int) var GrassIndex
export(int) var RockIndex

export(NodePath) var TileMapPath
onready var tilemap = get_node(TileMapPath)
export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

onready var RoomTiles = []
onready var RoomCenters = []
onready var RoomWalls = []
onready var OverlapWalls = []

func _ready():
	CreateMap()
	SpawnTiles()
	Player.global_position = tilemap.map_to_world(RoomCenters[0])
	
func CreateMap():
	for x in NumberRooms:
		var pos = Vector2(rand_range(DungeonSize.position.x, DungeonSize.position.x + DungeonSize.size.x), rand_range(DungeonSize.position.y, DungeonSize.position.y + DungeonSize.size.y))
		var size = Vector2(rand_range(4, MaxRoomSize.x), rand_range(4, MaxRoomSize.y))
		SetRoom(size, pos)

func SpawnTiles():
	print(len(OverlapWalls))
	for x in len(RoomTiles):
		tilemap.set_cell(RoomTiles[x].x, RoomTiles[x].y, GrassIndex)
	for y in len(RoomWalls):
		#tilemap.set_cell(RoomWalls[y].x, RoomWalls[y].y, RockIndex)
		pass
	for x in len(OverlapWalls):
		tilemap.set_cell(RoomTiles[x].x, RoomTiles[x].y, RockIndex)

func SetRoom(size, pos):
	var walls = []
	for x in int(size.x):
		for y in int(size.y):
			var newpos = Vector2(int(pos.x+x - (size.x/2)), int(pos.y+y - (size.y/2)))
			if y == 0 and x == 0:
				walls.append(newpos)
			else:
				RoomTiles.append(newpos)
	for x in len(walls):
		if WallOverlaps(x, walls, RoomTiles):
			OverlapWalls.append(walls[x])
			pass
		else:
			#RoomWalls.append(walls[x])
			pass
	RoomCenters.append(Vector2(pos.x, pos.y))

func WallOverlaps(id, walls, rooms):
	for y in len(rooms):
		var A = Vector2(int(walls[id].x), int(walls[id].y))
		var B = Vector2(int(rooms[y].x), int(rooms[y].y))
		if A == B:
			print(A, B)
			return true
	return false
	
