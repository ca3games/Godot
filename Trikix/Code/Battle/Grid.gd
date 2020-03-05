extends Node2D

onready var card = preload("res://Code/Battle/Cell.gd")
onready var card_object = preload("res://Scene/Cards/Cards.tscn")
var Map
var size = Vector2(10,10)
var offset = Vector2(40,100)
var space = Vector2(32,32)
var choice_offset = Vector2(250, 430)
var Choice
var Bomb_map
var bomb_active = false

enum e_type {
	clubs, diamonds, hearts, spades
}

enum e_piece {
	I, J, O, S, T, Z
}
enum e_side {
	up, down, left, right
}

var piece
var side
var type

func _ready():
	randomize()
	MakeMap()
	MakeChoice()
	NewPiece()
	ButtonTouch()
	$"../SCORE".text = str(Variables.score)

func MakeMap():
	Map = []
	Bomb_map = []
	
	for x in size.x:
		Map.append([])
		Bomb_map.append([])
		for y in size.y:
			Map[x].append([])
			Map[x][y] = card.new()
			var tmp = card_object.instance()
			tmp.position = Vector2(offset.x + (x * space.x), offset.y + (y * space.y))
			Map[x][y].cell = tmp
			Map[x][y].cell.type = 4
			Map[x][y].pos = Vector2(x, y)
			Map[x][y].cell.pos = Vector2(x, y)
			add_child(Map[x][y].cell)
			
			Bomb_map[x].append([])
			Bomb_map[x][y] = false

func NewPiece():
	randomize()
	piece = randi()%6
	side = randi()%4
	type = randi()%4
	ButtonTouch()

func ResetBombMap():
	for x in size.x:
		for y in size.y:
			Bomb_map[x][y] = false

func MakeChoice():
	Choice = []
	
	for x in 3:
		Choice.append([])
		for y in 3:
			Choice[x].append([])
			Choice[x][y] = card.new()
			var tmp = card_object.instance()
			tmp.position = Vector2(choice_offset.x + (x * space.x), choice_offset.y + (y * space.y))
			Choice[x][y].cell = tmp
			Choice[x][y].cell.type = 4
			Choice[x][y].cell.button = true
			Choice[x][y].pos = Vector2(x, y)
			Choice[x][y].cell.pos = Vector2(x, y)
			$"../Choice".add_child(Choice[x][y].cell)

func ResetRed():
	for x in size.x:
		for y in size.y:
			Map[x][y].cell.HideRed()

func ResetButton():
	for x in 3:
		for y in 3:
			Choice[x][y].type = card.card.empty
			Choice[x][y].cell.ChangeType(Choice[x][y].type)

func MapClick(x, y):
	if bomb_active:
		ResetBombMap()
		$"../Bomb/Button".disabled = false
		bomb_active = false
		var combo = 0
		var type = Map[x][y].type
		combo += $Code.Combo(x, y, x, y, size.x, size.y, Map, Bomb_map, type)
		Variables.score += combo
		$"../TimeBar".Combo()
		$"../SCORE".text = str(Variables.score)
	else:
		match(piece):
			e_piece.I: $Code.Make_I(x-1,y-1, size.x, size.y, Map, type, side, false)
			e_piece.J: $Code.Make_J(x-1,y-1, size.x, size.y, Map, type, side, false)
			e_piece.O: $Code.Make_O(x-1,y-1, size.x, size.y, Map, type, side, false)
			e_piece.S: $Code.Make_S(x-1,y-1, size.x, size.y, Map, type, side, false)
			e_piece.T: $Code.Make_T(x-1,y-1, size.x, size.y, Map, type, side, false)
			e_piece.Z: $Code.Make_Z(x-1,y-1, size.x, size.y, Map, type, side, false)

func ButtonTouch():
	match(side):
		e_side.left:
			side = e_side.down
		e_side.up:
			side = e_side.left
		e_side.right:
			side = e_side.up
		e_side.down:
			side = e_side.right
	ResetButton()
	match(piece):
		e_piece.I: $Code.Make_I(0,0, 3, 3, Choice, type, side, true)
		e_piece.J: $Code.Make_J(0,0, 3, 3, Choice, type, side, true)
		e_piece.O: $Code.Make_O(0,0, 3, 3, Choice, type, side, true)
		e_piece.S: $Code.Make_S(0,0, 3, 3, Choice, type, side, true)
		e_piece.T: $Code.Make_T(0,0, 3, 3, Choice, type, side, true)
		e_piece.Z: $Code.Make_Z(0,0, 3, 3, Choice, type, side, true)
	
