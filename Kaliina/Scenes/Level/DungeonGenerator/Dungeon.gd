extends Spatial

var Map
export (Vector2) var size
export (float) var offset
export (NodePath) var Pacifica

func _ready():
	var player = get_node(Pacifica)
	
	Map = $EmptyGenerator.GenerateMap(size.x, size.y)
	$FinalGenerator.Generate(Map, size.x, size.y, offset)
	player.PacificaStartPos($Map.map_to_world(3, size.y/2, 0))
