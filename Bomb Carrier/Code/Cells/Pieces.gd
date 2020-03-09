extends Node2D

var P1
var P2

onready var Piece = load("res://Code/Cells/Cell.gd")
onready var Piece_scene = preload("res://Scenes/Board/Piece.tscn")

func MakePieces():
	P1 = MakePlayer(0, 1, 2)
	P2 = MakePlayer(9, 8, 7)

func MakePlayer(y1, y2, y3):
	var player = []
	for id in range(0, 8):
		player.append([])
		if id < 5:
			MakePiece(player, id, id, y3, "POLICE")
		else:
			match(id):
				5: MakePiece(player, id, 1, y2, "SOLDIER")
				6: MakePiece(player, id, 3, y2, "SOLDIER")
				7: MakePiece(player, id, 2, y1, "BOMB")
	return player

func MakePiece(player, id, x, y, type):
	player[id] = Piece.new()
	player[id].pos = Vector2(x, y)
	match(type):
		"POLICE" :
			player[id].type = 1
		"SOLDIER" :
			player[id].type = 2
		"BOMB" :
			player[id].type = 0

func SpawnPieces(board):
	SpawnPlayer(board, P1, true)
	SpawnPlayer(board, P2, false)

func SpawnPlayer(board, player, p1):
	for i in range(0, 8):
		var tmp = Piece_scene.instance()
		tmp.position = board[player[i].pos.x][player[i].pos.y].cell.position
		player[i].cell = tmp
		player[i].cell.get_node("PIECE").frame = player[i].type
		if p1:
			player[i].cell.get_node("PIECE").modulate = Color.yellow
		else:
			player[i].cell.get_node("PIECE").modulate = Color.green
		add_child(player[i].cell)
