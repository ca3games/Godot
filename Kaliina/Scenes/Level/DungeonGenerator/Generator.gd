extends Spatial

onready var TileScript = load("res://Scenes/Level/DungeonGenerator/Tile.gd")

func GenerateMap(w, h):
	var Map = []
	for x in range(w):
		Map.append([])
		for y in range(h):
			Map[x].append([])
			var tile = TileScript.new()
			tile.pos = Vector2(x, y)
			tile.type = "EMPTY"
			Map[x][y] = tile
	
	return Map
		
