extends Node2D

var Cell = load("res://Code/Cell.gd")
onready var Cellscene = preload("res://Scene/Piece.tscn")
var AIscript = load("res://Code/AICell.gd")
var Map
var MapScore
var DamageMap
var P1MovesMap
var size = Vector2(7, 8)
var offset = Vector2(65, 60)
var Player1 = []
var Player2 = []
var P1Turn = true
var Piece
var movements
var p1hp = 100
var p2hp = 100
var thinking = false
var matchtype
var p1size = 0
var p2size = 0
var AIhelp = false

signal game_finished()

func _ready():
	matchtype = Variables.type
	
	if matchtype == Variables.typemode.network:
		if is_network_master():
			SetPlayerNamesLabel("MY SIDE", "OPPONENT SIDE", Color.blue, Color.red)
		else:
			SetPlayerNamesLabel("OPPONENT SIDE", "MY SIDE", Color.red, Color.blue)
	else:
		SetPlayerNamesLabel("Player 1", "Player 2", Color.blue, Color.red)
	
	
	MakeMap()
	MakePlayer(Player1, 1)
	MakePlayer(Player2, 2)
	CreateMap()
	UpdateMap()
	CreatePlayer(Player1)
	CreatePlayer(Player2)
	MakeBrown()
	UpdatePiecesLabel()
	SetHPLabels()
	var pos_size = Vector2((size.x*offset.x)/2, (size.y*offset.y)/2)
	$Camera2D.position = pos_size
	$Floor.position = Vector2(pos_size.x - (size.x*offset.x), pos_size.y - ((size.y*offset.y)/2) - 50)

func _process(delta):
	if P1Turn == false and matchtype == Variables.typemode.ai and thinking == 0:
		thinking += 1
		$AI.start(1)
		yield($AI, "timeout")
		Player2AITurn()
		P1Turn = true
		
	if Input.is_action_just_released("HELP"):
		#AIhelp = !AIhelp
		pass
	SetHPLabels()
	
	if Variables.type == Variables.typemode.network:
		if p1hp < 1 or p1size < 1:
			get_tree().get_root().get_node("Lobby").GAMEOVER(false)
		if p2hp < 1 or p2size < 1:
			get_tree().get_root().get_node("Lobby").GAMEOVER(true)
		ChangeTurnLabel()
	else:
		$GUI/Turn.text = "PLAYER 1 TURN" if P1Turn else "PLAYER 2 TURN"

func SetPlayerNamesLabel(P1, P2, Color1, Color2):
	find_node("P1HPLabel").text = P1
	find_node("P2HPLabel").text = P2
	$GUI/PanelP1.ChangeColor(Color1)
	$GUI/PanelP2.ChangeColor(Color2)

func MakePlayer(player, team):
	var id = 0
	var y
	if team == 1:
		y = 5
	else:
		y = 2
	for i in range(7):
		add(player, id, 6, Vector2(id, y), team, 10, 25)
		id += 1
	
	if team == 1:
		y = 6
	else:
		y = 1	
		
	add(player, id, 1, Vector2(0, y), team, 15, 22) 
	id += 1
	add(player, id, 1, Vector2(6, y), team, 15, 22) 
	id += 1
	
	add(player, id, 2, Vector2(1, y), team, 18, 18) 
	id += 1
	add(player, id, 2, Vector2(5, y), team, 18, 18) 
	id += 1
	
	add(player, id, 3, Vector2(3, y), team, 50, 3) 
	id += 1
	add(player, id, 4, Vector2(2, y), team, 25, 15) 
	id += 1
	add(player, id, 5, Vector2(4, y), team, 40, 7) 
	id += 1
	
	if team == 1:
		p1size = id
	else:
		p2size = id
	
func CreatePlayer(player):
	for i in range(0, player.size()):
		Map[player[i].pos.x][player[i].pos.y].cell.Update(player[i].type, player[i].player, Vector2(player[i].HP, player[i].FullHP))

func add(player, id, type, pos, team, HP, damage):
	player.append(Cell.new())
	player[id].type = type
	player[id].player = team
	player[id].pos = pos
	player[id].FullHP = HP
	player[id].HP = HP
	player[id].damage = damage

func MakeBrown():
	for x in range(size.x):
		Map[x][0].cell.SetBrown()
	
	for x in range(size.x):
		Map[x][size.y-1].cell.SetBrown()

func MakeMap():
	Map = []
	for x in range(size.x):
		Map.append([])
		for y in range(size.y):
			Map[x].append([])
			Map[x][y] = Cell.new()
			Map[x][y].pos = Vector2(x, y)
			Map[x][y].type = 0
			Map[x][y].player = 0
			Map[x][y].size = size
	
	if matchtype == Variables.typemode.ai:
		MapScore = []
		DamageMap = []
		P1MovesMap = []
		for x in range(size.x):
			MapScore.append([])
			DamageMap.append([])
			P1MovesMap.append([])
			for y in range(size.y):
				MapScore[x].append([])
				DamageMap[x].append([])
				P1MovesMap[x].append([])
				MapScore[x][y] = AIscript.new()
				DamageMap[x][y] = 0
				P1MovesMap[x][y] = false

func CleanMapScore():
	for x in range(size.x):
		for y in range(size.y):
			MapScore[x][y] = AIscript.new()
			DamageMap[x][y] = 0

func GetCellType(x, y):
	return Map[x][y].type
	
func SetCell(x, y, type, player, P, id, hp):
	Map[x][y].type = type
	Map[x][y].player = P
	Map[x][y].cell.Update(type, player, hp)
	Map[x][y].id = id
	if id == 999:
		Map[x][y].Move = 0

func CreateMap():
	for x in range(size.x):
		for y in range(size.y):
			Map[x][y].cell = Cellscene.instance()
			Map[x][y].cell.position = Vector2(x*offset.x, y*offset.y)
			Map[x][y].cell.pos = Vector2(x, y)
			self.add_child(Map[x][y].cell)

remotesync func UpdateMap():
	for x in range(size.x):
		for y in range(size.y):
			SetCell(x, y, 0, 1, 0, 999, Vector2(0,0))
	UpdatePlayer(Player1, 1)
	UpdatePlayer(Player2, 2)

func UpdatePlayer(player, P):
	for i in range(0, player.size()):
		if player[i].alive :
			SetCell(player[i].pos.x, player[i].pos.y, player[i].type, player[i].player, P, i, Vector2(player[i].HP, player[i].FullHP))

func SelectPieceNetwork(pos):
	var player = Map[pos.x][pos.y].player
	var move = Map[pos.x][pos.y].Move
	if is_network_master():
		if int(P1Turn) == 1:
			if IsBrown(pos) and move == 1 and pos.y < 1:
				rpc("AttackBrown", pos, Piece.x, true)
				rpc("UpdateMap")
				rpc("ResetReds")
				rpc("ResetReds")
				rpc("SetP1TurnRemote", false)
			elif IsGreen(pos) and move == 1:
				rpc("SetPiecePos", pos, Piece.x, Player1, 1)
				rpc("UpdateMap")
				rpc("ResetReds")
				rpc("ResetReds")
				rpc("SetP1TurnRemote", false)
			elif IsRed(pos) and move == 1:
				rpc("Attack", pos, true)
				rpc("UpdateMap")
				rpc("ResetReds")
				rpc("SetP1TurnRemote", false)
			else:
				if player == 1:
					rpc("ResetReds")
					rpc("PickPiece", pos)
					rpc("SetPieceRemote", pos)
	else:
		if int(P1Turn) != 1:
			if IsBrown(pos) and move == 2 and pos.y >= size.y-1:
				rpc("DamageP1")
				rpc("UpdateMap")
				rpc("ResetReds")
				rpc("SetP1TurnRemote", true)
			elif IsGreen(pos) and move == 2:
				rpc("SetPiecePos", pos, Piece.x, Player2, 2)
				rpc("UpdateMap")
				rpc("ResetReds")
				rpc("ResetReds")
				rpc("SetP1TurnRemote", true)
			elif IsRed(pos) and move == 2:
				rpc("Attack", pos, false)
				rpc("UpdateMap")
				rpc("ResetReds")
				rpc("SetP1TurnRemote", true)
			else:
				rpc("ResetReds")
				rpc("PickPiece", pos)
				rpc("SetPieceRemote", pos)	


remotesync func DamageP1():
	var damage = GetDamage()
	p1hp -= damage

remotesync func SetP1TurnRemote(boolean):
	P1Turn = boolean

remotesync func SetPieceRemote(pos):
	Piece = ReturnID(pos)
	SetHPLabels()

func ChangeTurnLabel():
	if is_network_master():
		if P1Turn:
			$GUI/Turn.text = "YOUR TURN"
		else:
			$GUI/Turn.text = "OPPONENT TURN"
	else:
		if P1Turn:
			$GUI/Turn.text = "OPPONENT TURN"
		else:
			$GUI/Turn.text = "YOUR TURN"

func SelectPiece(pos):
	var player = Map[pos.x][pos.y].player
	var move = Map[pos.x][pos.y].Move
	if int(P1Turn) == 1:
		Player1TurnHuman(pos, move, player)
	else:
		match(matchtype):
			Variables.typemode.human:
				Player2TurnHuman(pos, move, player)
	SetHPLabels()

func Player1TurnHuman(pos, move, player):
	if IsBrown(pos) and move == 1 and pos.y < 1:
		AttackBrown(Vector2(pos.x, pos.y), Piece.x, true)
		UpdateMap()
		ResetReds()
		P1Turn = false
		thinking = 0
	elif IsGreen(pos) and move == 1:
		SetPiecePos(pos, Piece.x, Player1)
		UpdateMap()
		ResetReds()
		P1Turn = false
		thinking = 0
	elif IsRed(pos) and move == 1:
		if matchtype == Variables.typemode.ai :
			Attack(pos, true)
		else:
			Attack(pos, true)
		UpdateMap()
		ResetReds()
		P1Turn = false
		thinking = 0
	else:
		if player == 1:
			ResetReds()
			PickPiece(pos)
			Piece = ReturnID(pos)

func Player2AITurn():
	CleanMapScore()
	var AI = []
	var posibles = GetMovement(Player2)
	AI = ComputeMovement(posibles, AI)
	#SetMapScore(AI)
	var emotion = SetEmotionMap(AI)
	SetEmotionalMapScore(emotion)
	#var best = GetBestMove()
	var best = GetBestEmotion(Vector2(999,999))
	#PrintP2Moves(best)
	if AIhelp:
		PrintP1Moves()
		PrintP2MovesEmotions(best)
		PrintBest2DMove(best)
		$AI.start(3)
	else:
		PrintBest2DMove(best)
		$AI.start(1)
	yield($AI, "timeout")
	MakeP2Move(best)
	$AI.start(0.5)
	yield($AI, "timeout")

func MakeP2Move(best):
	var id = ReturnID(Vector2(best.x, best.y))
	var pos = Vector2(best.x, best.y)
	if id.x == 999:
		if IsBrown(Vector2(best.x, best.y)) and best.y > 1:
			AttackBrown(Vector2(best.x, best.y), best.z, false)
			SetHPLabels()
		else:
			SetPiecePos(pos, best.z, Player2)
		UpdateMap()
		ResetReds()
	else:
		Piece = Vector2(best.z, 2)
		Attack(pos, false)
		UpdateMap()
		ResetReds()

func GetMax(AI):
	var maximum = Vector3(0,0,0)
	for id in range(0, AI.size()):
		if AI[id].final_score > maximum.x:
			maximum.x = AI[id].final_score
		if AI[id].enemy_priority > maximum.y:
			maximum.y = AI[id].enemy_priority
		if AI[id].danger_priority > maximum.z:
			maximum.z = AI[id].danger_priority
	
	return maximum

func SetEmotionMap(AI):
	var emotion = []
	var maximum = GetMax(AI)
	for id in range(0, AI.size()):
		if AI[id].HP < 1:
			continue
			
		emotion.append([])
		#get AICEll.gd script with emotion null
		emotion[id] = GetEmotionCell(AI, id)
		
		var score = emotion[id].final_score
		var enemy = emotion[id].enemy_priority
		var danger = emotion[id].danger_priority
		
		if score >= enemy and score >= danger:
			emotion[id].emotion = Variables.emotion.no_danger
		if enemy > score:
			emotion[id].emotion = Variables.emotion.attacking_move
		if danger > score:
			emotion[id].emotion = Variables.emotion.dangerous_move
		
		
	return emotion

func GetBestEmotion(pos):
	var best = Vector3(0,0,0)
	var best_score = 0
	var best_attack = 0
	var less_damage = 0
	for x in range(0, size.x):
		for y in range(0, size.y):
			if Vector2(x, y) == pos:
				continue
			var ID = ReturnID(Vector2(x, y))
			if MapScore[x][y].id != 999:
				var isbest = false
				var isattack = false
				var issafe = false
				var chosen = false
				
				if less_damage < MapScore[x][y].danger_priority:
					issafe = true
				if MapScore[x][y].enemy_priority > best_attack:
					isattack = true
				if MapScore[x][y].final_score > best_score:
					isbest = true
				
				if MapScore[x][y].emotion == Variables.emotion.no_danger:
					if ((issafe and !isattack) or (isbest and issafe)) and ID.y != 2:
						chosen = true
				
				if MapScore[x][y].emotion == Variables.emotion.dangerous_move:
					if isbest:
						chosen = true
				if isattack:
					chosen = true
										
				if chosen:
					best_score = MapScore[x][y].final_score
					best_attack = MapScore[x][y].enemy_priority
					less_damage = MapScore[x][y].danger_priority
					best = Vector3(MapScore[x][y].pos.x, MapScore[x][y].pos.y, MapScore[x][y].id)
	
	var emotion = MapScore[Player2[best.z].pos.x][Player2[best.z].pos.y].emotion
		
	return best


remotesync func UpdatePiecesLabel():
	$GUI/P1Pieces.text = str(p1size) + " pieces"
	$GUI/P2Pieces.text = str(p2size) + " pieces"
	if Variables.type == Variables.typemode.network:
		pass
	else:
		if p1size < 1:
			Variables.GameOver(false)
		if p2size < 1:
			Variables.GameOver(true)

func GetBestMove():
	var best = Vector3(0,0,0)
	var best_score = 0
	var best_attack = 0
	var best_damage = 0
	for x in range(0, size.x):
		for y in range(0, size.y):
			var tmp_score = 0
			var tmp_attack = 0
			var tmp_damage = 0
			if MapScore[x][y].id != 999:
				if MapScore[x][y].final_score > best_score:
					tmp_score = MapScore[x][y].final_score
				if tmp_score < MapScore[x][y].enemy_priority:
					tmp_attack = MapScore[x][y].enemy_priority
				if best_damage > MapScore[x][y].danger_priority:
					tmp_damage = MapScore[x][y].danger_priority
				
				var final = (tmp_score + tmp_attack)
				
				if final > best_score or tmp_score < tmp_damage:
					best = Vector3(MapScore[x][y].pos.x, MapScore[x][y].pos.y, MapScore[x][y].id)
					best_score = final
					best_attack = MapScore[x][y].enemy_priority
					best_damage = MapScore[x][y].danger_priority
	return best

func PrintBest2DMove(best):
	Map[best.x][best.y].cell.ShowBar(Color.red)
	var pos = Player2[best.z].pos
	Map[pos.x][pos.y].cell.ShowBar(Color.darkred)

func SetEmotionalMapScore(AI):
	for id in range(0, AI.size()):
		var team = ReturnID(AI[id].pos).y
		if AI[id].HP < 1:
			continue
		else:
			if team == 1:
				SetMapScoreCell(AI, id, Variables.emotion.attacking_move)
				continue
			SetMapScoreCell(AI, id, AI[id].emotion)
				
	
func SetMapScore(AI):
	for id in range(0, AI.size()):
		if AI[id].HP < 1:
			continue
		DamageMap[AI[id].pos.x][AI[id].pos.y] += AI[id].danger_priority
	
	for id in range(0, AI.size()):
		if AI[id].HP < 1:
			continue
		var scoremap = MapScore[AI[id].pos.x][AI[id].pos.y].final_score
		var myscore = AI[id].final_score
		myscore -= DamageMap[AI[id].pos.x][AI[id].pos.y]
		if myscore < 1:
			myscore = 10
			SetMapScoreCell(AI, id, AI[id].emotion)
		if myscore >= scoremap:
			SetMapScoreCell(AI, id, AI[id].emotion)
	
	for id in range(0, AI.size()):
		if AI[id].HP < 1:
			continue
		var attack = AI[id].danger_priority
		var cell_attack = MapScore[AI[id].pos.x][AI[id].pos.y].danger_priority
		if cell_attack <= attack:
			SetMapScoreCell(AI, id, AI[id].emotion)

func SetMapScoreCell(AI, id, emotion):
	MapScore[AI[id].pos.x][AI[id].pos.y].pos = AI[id].pos
	MapScore[AI[id].pos.x][AI[id].pos.y].move_points += AI[id].move_points
	MapScore[AI[id].pos.x][AI[id].pos.y].advance_points += AI[id].advance_points
	MapScore[AI[id].pos.x][AI[id].pos.y].retreat_points += AI[id].retreat_points
	MapScore[AI[id].pos.x][AI[id].pos.y].priority = AI[id].priority
	MapScore[AI[id].pos.x][AI[id].pos.y].id = AI[id].id
	MapScore[AI[id].pos.x][AI[id].pos.y].danger_priority += AI[id].danger_priority
	MapScore[AI[id].pos.x][AI[id].pos.y].enemy_priority += AI[id].enemy_priority
	MapScore[AI[id].pos.x][AI[id].pos.y].final_score = AI[id].final_score
	MapScore[AI[id].pos.x][AI[id].pos.y].emotion = emotion
		
func GetEmotionCell(AI, id):
	var emotion = AIscript.new()
	emotion.pos = AI[id].pos
	emotion.HP = AI[id].HP
	emotion.move_points += AI[id].move_points
	emotion.advance_points += AI[id].advance_points
	emotion.retreat_points += AI[id].retreat_points
	emotion.priority = AI[id].priority
	emotion.id = AI[id].id
	emotion.danger_priority += AI[id].danger_priority
	emotion.enemy_priority += AI[id].enemy_priority
	emotion.final_score = AI[id].final_score
	
	return emotion

func ComputeMovement(posibles, AI):
	for id in range(0, posibles.size()):
		AI.append(AIscript.new())
		AI[id].HP = Player2[posibles[id].z].HP
		AI[id].pos = Vector2(posibles[id].x, posibles[id].y)
		AI[id].id = posibles[id].z
		if ReturnID(Vector2(posibles[id].x, posibles[id].y)).x != 999:
			AI[id].move_points = 0
		else:
			AI[id].move_points = 10
		AI[id].priority = Player2[posibles[id].z].GetMyPriority()
		if AI[id].pos.y > Player2[posibles[id].z].pos.y:
			AI[id].advance_points += 50
		if AI[id].pos.y < Player2[posibles[id].z].pos.y:
			AI[id].retreat_points += 10
		var enemy = IsPosTarget(AI[id].pos)
		if enemy != 999:
			var priority = Player1[posibles[id].z].GetDangerPriority()
			var HP = Player1[posibles[id].z].HP
			var ratio
			if HP < 1 :
				ratio = 0
			else:
				ratio	 = Player1[posibles[id].z].FullHP / HP
			AI[id].enemy_priority = (priority + AI[id].priority) * ratio
			
		var dangerID = IsMoveDangerous(AI[id].pos)
		if dangerID != 999:
			AI[id].danger_priority = Player1[dangerID].GetDamage() + Player1[dangerID].GetDangerPriority()
	
		var score = 0
		score += AI[id].move_points
		score += AI[id].advance_points
		score += AI[id].retreat_points
		score += AI[id].priority
		score += AI[id].enemy_priority
		AI[id].final_score = score
	
	return AI

func IsPosTarget(pos):
	for i in range(0, Player1.size()):
		var id = ReturnID(Player1[i].pos)
		if id.x != 999 and Player1[id.x].pos == pos:
			return id.x
	return 999


func IsMoveDangerous(pos):
	for id in range(0, Player1.size()):
		var moves
		moves = GetMovement(Player1)
		for i in range(0, moves.size()):
			if Vector2(moves[i].x, moves[i].y) == pos:
				return moves[i].z
	return 999

func IsMoveDangerous_2(pos):
	for id in range(0, Player1.size()):
		var moves
		moves = GetMovement(Player1)
		for i in range(0, moves.size()):
			P1MovesMap[moves[i].x][moves[i].y] = true
	if P1MovesMap[pos.x][pos.y]:
		return true
	else:
		return false
			
func CleanP1MovesMap():
	for x in range(0, size.x):
		for y in range(0, size.y):
			P1MovesMap[x][y] = false

func PrintP1Moves():
	for x in range(0, size.x):
		for y in range(0, size.y):
			if P1MovesMap[x][y]:
				Map[x][y].cell.ShowColor(Color.yellowgreen)

func PrintP2Moves(best):
	for x in range(0, size.x):
		for y in range(0, size.y):
			if MapScore[x][y].id != 999:
				var score = 0
				var enemy = 0
				var danger = 0
				score = MapScore[x][y].final_score
				enemy = MapScore[x][y].enemy_priority
				danger = MapScore[x][y].danger_priority
				Map[x][y].cell.ShowScore(score, enemy, MapScore[x][y].id, danger)
				enemy /= 2
				Map[x][y].cell.ShowColor(Color8(enemy, danger, score, 255))
				Map[best.x][best.y].cell.ShowBar(Color.red)

func PrintP2MovesEmotions(best):
	for x in range(0, size.x):
		for y in range(0, size.y):
			if MapScore[x][y].id != 999:
				var color
				var score = MapScore[x][y].final_score
				var attack = MapScore[x][y].enemy_priority
				var id = MapScore[x][y].id
				var danger = MapScore[x][y].danger_priority
				match(MapScore[x][y].emotion):
					Variables.emotion.empty_value: 
						color = Color.darkgray
					Variables.emotion.no_danger: 
						color = Color.blue
					Variables.emotion.dangerous_move: 
						color = Color.yellow
					Variables.emotion.attacking_move: 
						color = Color.red
				Map[x][y].cell.ShowColor(color)
				Map[best.x][best.y].cell.ShowBar(Color.red)
				Map[x][y].cell.ShowScore(score, attack, id, danger)

func GetMovement(player):
	var posible = []
	for id in range(0, player.size()):
		var moves = []
		if player[id].HP < 1:
			continue
		moves = GetPosibleMovements(player[id].pos)
		for pos in range(0, moves.size()):
			posible.append(Vector3(moves[pos].x, moves[pos].y, id))
	
	return posible
	
func IsPosInDanger(pos):
	var id = 999
	
	return id

func Player2TurnHuman(pos, move, player):
	#Deals HP damage to brown cells (enemy lifebar)
	if IsBrown(pos) and move == 2 and pos.y >= size.y-1:
		var damage = GetDamage()
		p1hp -= damage
		UpdateMap()
		ResetReds()
		P1Turn = true
	#If movement is free
	elif IsGreen(pos) and move == 2:
		SetPiecePos(pos, Piece.x, Player2)
		UpdateMap()
		ResetReds()
		P1Turn = true
	#If movement is enemy
	elif IsRed(pos) and move == 2:
		Attack(pos, false)
		UpdateMap()
		ResetReds()
		P1Turn = true
	else:
		if player == 2:
			ResetReds()
			PickPiece(pos)
			Piece = ReturnID(pos)

remotesync func SetPiecePos(newpos, id, player, team = 0):
	if team == 0:
		player[id].pos = newpos
	elif team == 1:
		Player1[id].pos = newpos
	elif team == 2:
		Player2[id].pos = newpos
	UpdateMap()

func IsGreen(pos):
	return Map[pos.x][pos.y].cell.GetRed()

func IsRed(pos):
	return Map[pos.x][pos.y].cell.GetTarget()

remotesync func PickPiece(pos):
	var team = Map[pos.x][pos.y].GetTeam()
	if team != 0:
		ShowMovement(pos)

func ShowMovement(pos):
	movements = []
	movements = Map[pos.x][pos.y].GetPossibleMovement()
	for i in range(0, movements.size()):
		Map[movements[i].x][movements[i].y].cell.SetRed(true)
		Map[movements[i].x][movements[i].y].Move = 1 if P1Turn else 2

func GetPosibleMovements(pos):
	movements = []
	movements = Map[pos.x][pos.y].GetPossibleMovement()
	return movements
		
	
remotesync func ResetReds():
	for x in range(size.x):
		for y in range(size.y):
			Map[x][y].cell.SetRed(false)

func ReturnID(pos):
	var id = Map[pos.x][pos.y].id
	var team = Map[pos.x][pos.y].GetTeam()
	return Vector2(id, team)

remotesync func Attack(pos, team1):
	var tmp = ReturnID(pos)
	
	if team1:
		Player2[tmp.x].HP -= Player1[Piece.x].damage
		if Player2[tmp.x].HP < 1 :
			Player2[tmp.x].alive = false
			p2size -= 1
	else:
		Player1[tmp.x].HP -= Player2[Piece.x].damage
		if Player1[tmp.x].HP < 1:
			Player1[tmp.x].alive = false
			p1size -= 1
	
	if Variables.type == Variables.typemode.network:
		rpc("UpdatePiecesLabel")
	else:
		UpdatePiecesLabel()

remotesync func AttackBrown(pos, id, team1):
	if team1:
		if pos.y <= 0:
			p2hp -= Player1[id].damage
			if p2hp < 1:
				if Variables.type == Variables.typemode.network:
					pass
				else:
					GameOver(true)
	else:
		if pos.y >= size.y - 1:
			p1hp -= Player2[id].damage
			if p1hp < 1:
				if Variables.type == Variables.typemode.network:
					pass
				else:
					GameOver(false)


remotesync func SetHPLabels():
	$GUI/P1HP.text = str(p1hp)
	$GUI/P2HP.text = str(p2hp)
	
func IsBrown(pos):
	if Map[pos.x][pos.y].cell.IsBrown():
		return true
	else:
		return false
		
func GetDamage():
	if P1Turn:
		return Player1[Piece.x].damage
	else:
		return Player2[Piece.x].damage
			
remote func GameOver(winnerP1):
	if Variables.type == Variables.typemode.network:
		get_tree().get_root().get_node("Lobby").GAMEOVER(winnerP1)
	else:
		Variables.GameOver(winnerP1)