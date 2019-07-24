extends Node

onready var HPvar = load("res://Code/Map Code/HPVar.gd")
var Player
onready var Player_scene = preload("res://Scenes/Player/Player.tscn")
onready var Map = $"../Map"
var Waifu
onready var Waifu_scene = preload("res://Scenes/Girls/KinematicGirls.tscn")

onready var Goblin = preload("res://Scenes/Enemies/Goblin.tscn")
var Enemies = []

func _ready():
	randomize()
	yield(get_tree(), "idle_frame")
	Player = HPvar.new()
	Player.HP = 100
	Player.MaxHP = 100
	Player.pos = Vector2(Map.mapsize.x / 2, Map.mapsize.y - 4)
	Player.Scene = Player_scene.instance()
	Player.Scene.position = Player.pos * Map.mapoffset + Map.mappos
	$"../../YSort".add_child(Player.Scene)
	Waifu = HPvar.new()
	Waifu.pos = Vector2(Map.mapsize.x / 2, Map.mapsize.y / 2)
	Waifu.Scene = Waifu_scene.instance()
	Waifu.Scene.position = Waifu.pos * Map.mapoffset + Map.mappos
	$"../../YSort".add_child(Waifu.Scene)
	
	
	MakeEnemies()
	

func _input(event):
	if Input.is_action_just_released("ENTER"):
		Variables.ResetMap()

func MakeEnemies():
	for i in range(0, 3):
		var x2 = rand_range(0, Map.mapsize.x)
		var y2 = rand_range(0, Map.mapsize.y)
		SpawnEnemy(x2, y2, 1, 1)
		SpawnEnemy(x2, y2, Map.mapsize.x-2, Map.mapsize.y-2)
		
func SpawnEnemy(x, y, x1, y1):
	if Map.Map[x1][y].type == "empty":
		AddEnemy(x1, y)
	elif Map.Map[x][y1].type == "empty":
		AddEnemy(x, y1)
	else:
		var x2 = rand_range(0, Map.mapsize.x)
		var y2 = rand_range(0, Map.mapsize.y)
		SpawnEnemy(x2, y2, x1, y1)

func AddEnemy(x, y):
	Enemies.append(HPvar.new())
	Enemies[len(Enemies)-1].HP = 50
	Enemies[len(Enemies)-1].pos = Vector2(x, y)
	Enemies[len(Enemies)-1].Scene = Goblin.instance()
	Enemies[len(Enemies)-1].Scene.position = Enemies[len(Enemies)-1].pos * Map.mapoffset + Map.mappos
	$"../../YSort".add_child(Enemies[len(Enemies)-1].Scene)