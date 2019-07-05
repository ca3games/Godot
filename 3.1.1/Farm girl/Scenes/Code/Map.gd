extends Node

var Map
var mapsize = Vector2(30,30)
var offset = 0.31
onready var start_pos = Vector2(mapsize.x / 2, mapsize.y-4)
onready var camera = get_tree().get_root().get_node("Map/Camera")
onready var Player = load("res://Scenes/Code/Player.gd")
onready var player_node = preload("res://Scenes/RogueMap/Pacifica.tscn")
var player
var camerapos
onready var cameratween = get_tree().get_root().get_node("Map/CameraTween")
var idlecamera = true
var idle = true

func _ready():
	Map = $MapGenerator.GenerateMap(mapsize, offset)
	$MapGenerator.InstantiateMap(Map, mapsize)
	camera.global_transform.origin = Vector3(start_pos.x*offset, 1, start_pos.y*offset)
	player = Player.new()
	player.Player = player_node.instance()
	var player_pos = Vector2(start_pos.x, start_pos.y-3)
	player.pos = player_pos
	camerapos = start_pos
	player.Player.global_transform.origin = Vector3(player_pos.x*offset, 0.2, (player_pos.y)*offset)
	get_parent().get_node("Entities").add_child(player.Player)

func _process(delta):
	if idle and idlecamera:
		CheckMovement()
	
	if idlecamera:
		CheckCameraMove()

func CheckMovement():
	idle = false
	get_parent().get_node("Movement").start(0.3)
	var left = false
	var right = false
	var down = false
	var up = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("UP"):
		up = true
	if Input.is_action_pressed("DOWN"):
		down = true
	
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


func CheckCameraMove():
	var distance_x = abs (camerapos.x - player.pos.x)
	if distance_x > 3:
		if camerapos.x - player.pos.x > 0 :
			MoveCamera(Vector2(-3, 0))
		else:
			MoveCamera(Vector2(3, 0))
	var distance_y = abs(player.pos.y - camerapos.y)
	if distance_y > 8:
		MoveCamera(Vector2(0, -8))
	if distance_y < 3:
		MoveCamera(Vector2(0, 2))

func MoveCamera(pos):
	if IsValid(camerapos + pos):
		idlecamera = false
		camerapos += pos
		var new_pos = GetPosition(camerapos)
		new_pos.y += 1
		cameratween.interpolate_property(camera, "translation", camera.global_transform.origin, new_pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		cameratween.start()
		idlecamera = true
	elif camerapos.y + pos.y >= mapsize.y:
		var new_pos = camerapos + pos
		var tmp = GetPosition(Vector2(new_pos.x, mapsize.y-1))
		idlecamera = false
		tmp.y = 1
		tmp.z += offset * 4
		cameratween.interpolate_property(camera, "translation", camera.global_transform.origin, tmp, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		cameratween.start()
		idlecamera = true


func GetPosition(pos):
	return Vector3(Map[pos.x][pos.y].position.x, 0, Map[pos.x][pos.y].position.y)

func SetPlayerPos(new):
	if IsValid(player.pos + new):
		player.pos += new
		var new_pos = GetPosition(player.pos)
		new_pos.y += 0.2
		player.Player.global_transform.origin = new_pos
	

func IsValid(pos):
	if pos.x > 0 and pos.y > 0 and pos.x < mapsize.x and pos.y < mapsize.y:
		if !Map[pos.x][pos.y].wall:
			return true
	return false


func _on_Movement_timeout():
	idle = true
