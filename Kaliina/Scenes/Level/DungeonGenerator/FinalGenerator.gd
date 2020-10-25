extends Spatial

export (NodePath) var GridNode

func Generate(Map, w, h, offset):
	var Grid = get_node(GridNode)
		
	for x in range(w):
		for y in range(h):
			var tile
			match (Map[x][y].type):
				"EMPTY" : Grid.set_cell_item(x, 0, y, 0, 0)
