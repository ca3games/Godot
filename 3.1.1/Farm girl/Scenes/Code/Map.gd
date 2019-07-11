extends Node

var Map
var mapsize = Vector2(50,50)
var offset = 0.31
onready var start_pos = Vector2(mapsize.x / 2, mapsize.y-4)
onready var camera
onready var Player = load("res://Scenes/Code/Player.gd")
onready var player_node = preload("res://Scenes/RogueMap/Pacifica.tscn")
onready var rosa_node = preload("res://Scenes/RogueMap/Rosa.tscn")
onready var Cell = load("res://Scenes/Code/Cell.gd")
onready var InfoLabel = $"../../../../CanvasLayer/Panel/VBoxContainer/HBoxContainer/Info"
var player
var rosa
var camerapos
onready var cameratween
var idlecamera = true
var idle = true
var Enemies
onready var RosaAstar


func _ready():
	camera = get_tree().get_root().get_node("Root/ViewportContainer/Viewport/Map/Camera")
	cameratween = get_tree().get_root().get_node("Root/ViewportContainer/Viewport/Map/CameraTween")
	RosaAstar = $AStar
	Map = $MapGenerator.GenerateMap(mapsize, offset)
	$MapGenerator.GenerateRocks(Map, mapsize)
	$MapGenerator.InstantiateMap(Map, mapsize)
	camera.global_transform.origin = Vector3(start_pos.x*offset, 1, start_pos.y*offset)
	player = Player.new()
	player.Player = player_node.instance()
	rosa = Player.new()
	rosa.Player = rosa_node.instance()
	var player_pos = Vector2(start_pos.x, start_pos.y-3)
	player.pos = player_pos
	rosa.pos = player_pos + Vector2(1, 0)
	camerapos = start_pos
	player.Player.global_transform.origin = Vector3(player_pos.x*offset, 0.2, (player_pos.y)*offset)
	rosa.Player.global_transform.origin = Vector3(rosa.pos.x*offset, 0.2, (rosa.pos.y)*offset)
	get_parent().get_node("Entities").add_child(player.Player)
	get_parent().get_node("Entities").add_child(rosa.Player)
	$MapGenerator.SetDarkMap(Map, mapsize, player.pos)
	Map[player.pos.x][player.pos.y].Tile.ChangeColor(Color.red)
	Map[rosa.pos.x][rosa.pos.y].Tile.ChangeColor(Color.blue)
	
	Enemies = $MapGenerator.GenerateEnemies(Map, mapsize)
	$MapGenerator.SpawnEnemies(Map, Enemies)

func _process(delta):
	if idlecamera and idle:
		CheckMovement()
		if GetDistance(player.pos, rosa.pos) > 4:
			RosaFollow()
	
	if idlecamera:
		CheckCameraMove()
	
	#$MapGenerator.PrintInfo(Map, mapsize)

func CheckMovement():
	var left = false
	var right = false
	var down = false
	var up = false
	
	if Input.is_action_just_released("LEFT"):
		left = true
	else:
		left = false
	if Input.is_action_just_released("RIGHT"):
		right = true
	else:
		right = false
	if Input.is_action_just_released("UP"):
		up = true
	else:
		up = false
	if Input.is_action_just_released("DOWN"):
		down = true
	else:
		down = false
	
	if left and !right and !up and !down:
		SetPlayerPos(Vector2(-1, 0))
		player.Player.Move_Anim("left")
	if right and !left and !up and !down:
		SetPlayerPos(Vector2(1, 0))
		player.Player.Move_Anim("right")
	if up and !left and !right and !down:
		SetPlayerPos(Vector2(0, -1))
		player.Player.Move_Anim("back")
	if down and !left and !right and !up:
		SetPlayerPos(Vector2(0, 1))
		player.Player.Move_Anim("front")


func GetDistance(pos, target):
	return abs(pos.x - target.x) + abs(pos.y - target.y)

func CheckCameraMove():
	MoveCamera()
	

func GetDirection(pos, target):
	return (pos.x - target.x) + (pos.y + target.y)

func GetDistanceX(pos, target):
	return pos.x - target.x

func GetDistanceY(pos, target):
	return pos.y - target.y

func MoveCamera():
	var direction = 5
	var new_pos = camerapos * offset
	if camerapos.x < player.pos.x - 4:
		camerapos.x += 1
		new_pos = camerapos * offset
	if camerapos.x > player.pos.x + 4:
		camerapos.x -= 1
		new_pos = camerapos * offset
	var distanceY = camerapos.y - player.pos.y
	#CAMERA DOWN
	if distanceY > 7:
		#print("camera down")
		camerapos.y -= 1
		new_pos =  camerapos * offset
	#CAMERA UP
	if distanceY < 5:
		#print("camera up")
		camerapos.y += 1
		new_pos = camerapos * offset
	idlecamera = false
	var pos = Vector3(new_pos.x, 1, new_pos.y)
	cameratween.interpolate_property(camera, "translation", camera.global_transform.origin, pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	cameratween.start()
	idlecamera = true

func GetPosition(pos):
	return Vector3(Map[pos.x][pos.y].position.x, 0, Map[pos.x][pos.y].position.y)

func SetPlayerPos(new):
	PrintInfo(player.pos + new)
	if IsValid(player.pos + new):
		player.pos += new
		var new_pos = GetPosition(player.pos)
		new_pos.y += 0.2
		player.Player.global_transform.origin = new_pos
		
		$MapGenerator.SetDarkMap(Map, mapsize, player.pos)
		Map[player.pos.x][player.pos.y].Tile.ChangeColor(Color.red)

func RosaFollow():
	idle = false
	RosaAstar.FindPath(Map, rosa.pos, player.pos, mapsize)
	var new_pos
	if $LoopMovementBug.time_left <= 0:
		$LoopMovementBug.start(1)
		rosa.loop_bug = 1
		new_pos = RosaAstar.getNext(rosa.loop_bug)
	else:
		rosa.loop_bug += 1
		if rosa.loop_bug > 2:
			rosa.loop_bug = 3
		new_pos = RosaAstar.getNext(rosa.loop_bug)	
	rosa.pos = new_pos
	MoveNode(rosa.Player, Vector3(rosa.pos.x * offset, 0.2, rosa.pos.y * offset))
	
	var dis_x = GetDistanceX(rosa.pos, player.pos)
	var dis_y = GetDistanceY(rosa.pos, player.pos)
	var left = false
	var right = false
	var up = false
	var down = false
	
	var direction = 5
	if dis_x < -2:
		left = true
	if dis_x > 2:
		right = true
	if dis_y < -2:
		down = true
	if dis_y > 2:
		up = true
	
	if up:
		direction = 8
	if down:
		direction = 2
	if left:
		direction = 4
	if up and left:
		direction = 7
	if down and left:
		direction = 1
	if right:
		direction = 6
	if up and right:
		direction = 9
	if down and right:
		direction = 3
	
	match(direction):
		4: rosa.Player.Move_Anim("right")
		6: rosa.Player.Move_Anim("left")
		2: rosa.Player.Move_Anim("front")
		1: rosa.Player.Move_Anim("front left")
		8: rosa.Player.Move_Anim("back")
		3: rosa.Player.Move_Anim("front right")
		7: rosa.Player.Move_Anim("back left")
		9: rosa.Player.Move_Anim("back right")
	
	idle = true

func MoveNode(node, newpos):
	$Move.interpolate_property(node, "translation", node.global_transform.origin, newpos, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Move.start()

func PrintInfo(pos):
	if pos.x >= 0 and pos.y >= 0 and pos.x <= mapsize.x-1 and pos.y <= mapsize.y:
		InfoLabel.text = "Info : " + str(Map[pos.x][pos.y].Gettype())

func IsValid(pos):
	if pos.x > 0 and pos.y > 0 and pos.x < mapsize.x and pos.y < mapsize.y:
		if Map[pos.x][pos.y].item == Cell.type.empty:
			return true
	return false


func _on_Movement_timeout():
	idle = true


func _on_LoopMovementBug_timeout():
	rosa.loop_bug = 1
