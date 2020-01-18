extends Node2D

onready var astar = AStar.new()
var tranversable
onready var tilemap = $"../../TileMap"
onready var half_cell_size 

func _ready():
	half_cell_size = tilemap.cell_size / 2

func MakeGrid():
	tranversable = $"../../TileMap".get_used_cells()
	for tile in tranversable:
		var id = GetID(tile)
		if tilemap.get_cell(tile.x, tile.y) != 0:
			astar.add_point(id, Vector3(tile.x, tile.y, 0), 5)
		else:
			astar.add_point(id, Vector3(tile.x, tile.y, 0), 2)
			
	for tile in tranversable:
		var id = GetID(tile)
		
		
		AddCoord(id, tile, -1, 0)
		AddCoord(id, tile, 1, 0)
		AddCoord(id, tile, 0, -1)
		AddCoord(id, tile, 0, 1)

func AddCoord(id, tile, x, y):
	var target = tile + Vector2(x, y)
	var target_id = GetID(target)
	if tile == target or not astar.has_point(target_id):
		return
	if tilemap.get_cell(target.x, target.y) == 0:
		astar.connect_points(id, target_id, true)

func GetID(tile):
	var used = tilemap.get_used_rect()
	var x = tile.x  - used.position.x
	var y = tile.y - used.position.y
	
	return x + y * used.size.x
	
func GetPath(start, end):
	
	var start_tile = tilemap.world_to_map(GetPosition(start))
	var end_tile = tilemap.world_to_map(GetPosition(end))
	
	var start_id = GetID(start_tile)
	var end_id = GetID(end_tile)
	
	if not astar.has_point(start_id) or not astar.has_point(end_id):
		return null
	
	var path_map = astar.get_point_path(start_id, end_id)
	var path_world = []
	for point in path_map:
		var point_world = tilemap.map_to_world(Vector2(point.x, point.y)) + half_cell_size
		path_world.append(point_world)
	
	return path_world

func GetPosition(pos):
	return tilemap.map_to_world(Vector2(pos.x, pos.y))

func PrintPath(path):
	for pos in path:
		var tile = tilemap.world_to_map(pos)
		tilemap.set_cell(tile.x, tile.y, 4)

func MakeNearBlocks(path, map, mapsize):
	for pos in path:
		var tile = tilemap.world_to_map(pos)
		map[tile.x][tile.y].nearcost = 50
	
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			if map[x][y].nearcost == 50:
				SetBlockCost(x, y, -2, 0, mapsize, map, 15)
				SetBlockCost(x, y, 2, 0, mapsize, map, 15)
				SetBlockCost(x, y, 0, -2, mapsize, map, 15)
				SetBlockCost(x, y, 0, 2, mapsize, map, 15)
				SetBlockCost(x, y, -1, 0, mapsize, map, 30)
				SetBlockCost(x, y, 1, 0, mapsize, map, 30)
				SetBlockCost(x, y, 0, -1, mapsize, map, 30)
				SetBlockCost(x, y, 0, 1, mapsize, map, 30)
				

func PrintDistance(Map, mapsize):
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			if Map[x][y].nearcost == 30:
				tilemap.set_cell(x, y, 5)
			if Map[x][y].nearcost == 15:
				tilemap.set_cell(x, y, 6)

func SetBlockCost(x, y, x2, y2, mapsize, map, cost):
	if IsValid(Vector2(x+x2, y+y2), mapsize, map):
		map[x+x2][y+y2].nearcost = cost

func IsValid(pos, mapsize, map):
	if pos.x > 0 and pos.x < mapsize.x and pos.y > 0 and pos.y < mapsize.y:
		if tilemap.get_cell(pos.x, pos.y) == 0:
			if map[pos.x][pos.y].nearcost == 0:
				return true
	return false