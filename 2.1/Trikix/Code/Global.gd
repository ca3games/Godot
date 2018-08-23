extends Node

enum type { l, L, square, cross, N, Z, T, bomb }
enum shape { corazon, diamante, pica, trebol }
enum orientation { top, right, bottom, left }

var tipo = type.l
var colour = shape.corazon
var side = orientation.top

func _ready():
	_newpiece()

func _newpiece():
	tipo = _newType()
	colour = _newShape()
	side = _newSide()

func _newType():
	randomize()
	var i = randi()% 7 + 1
	if i == 1:
		return type.l
	if i == 2:
		return type.L
	if i == 3:
		return type.square
	if i == 4:
		return type.cross
	if i == 5:
		return type.N
	if i == 6:
		return type.Z
	if i == 7:
		return type.T
	return _newType()

func _newShape():
	randomize()
	var i = randi()% 4 + 1
	if i == 1:
		return shape.corazon
	if i == 2:
		return shape.diamante
	if i == 3:
		return shape.pica
	if i == 4:
		return shape.trebol
	return _newShape()
	
func _newSide():
	randomize()
	var i = randi()% 4 + 1
	if i == 1:
		return orientation.top
	if i == 2:
		return orientation.right
	if i == 3:
		return orientation.bottom
	if i == 4:
		return orientation.left
	return _newSide()