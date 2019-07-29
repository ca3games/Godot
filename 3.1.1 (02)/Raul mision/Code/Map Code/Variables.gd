extends Node

onready var HPvar = load("res://Code/Map Code/HPVar.gd")
var Player
onready var Player_scene = preload("res://Scenes/Player/Player.tscn")
onready var Map = $"../Map"
var Waifu
onready var Waifu_scene = preload("res://Scenes/Girls/KinematicGirls.tscn")
onready var corpse = preload("res://Scenes/Enemies/Corpse.tscn")
onready var Goblin = preload("res://Scenes/Enemies/Goblin.tscn")
var Enemies = []
var enemies_left = 0

func _ready():
	randomize()
	yield(get_tree(), "idle_frame")
	Player = HPvar.new()
	Player.pos = Vector2(Map.mapsize.x / 2, Map.mapsize.y - 4)
	Player.Scene = Player_scene.instance()
	Player.Scene.position = Player.pos * Map.mapoffset + Map.mappos
	$"../../YSort".add_child(Player.Scene)
	Waifu = HPvar.new()
	Waifu.pos = Vector2(Map.mapsize.x / 2, Map.mapsize.y / 2)
	Waifu.Scene = Waifu_scene.instance()
	Waifu.Scene.pos = Waifu.pos
	Waifu.Scene.position = Waifu.pos * Map.mapoffset + Map.mappos
	$"../../YSort".add_child(Waifu.Scene)
	
	$"../../GUI".score(Variables.score)
	MakeEnemies()

func MakeEnemies():
	for i in range(0, 2):
		SpawnEnemyOP("warrior", true)
		SpawnEnemyOP("warrior", false)
		SpawnEnemyOP("archer", true)
		var chance = randi()%3 + 1
		if chance < 2:
			SpawnEnemyOP("warrior", false)
		else:
			SpawnEnemyOP("archer", true)
	var chance = randi()%3 + 1
	if chance < 2:
		SpawnEnemyOP("summoner", false)
		SpawnEnemyOP("white", true)
	else:
		SpawnEnemyOP("summoner", true)
		SpawnEnemyOP("white", false)

func SpawnEnemyOP(type, left):
	var x2 = rand_range(0, Map.mapsize.x)
	var y2 = rand_range(0, Map.mapsize.y)
	if left:
		SpawnEnemy(x2, y2, 1, 1, type)
	else:
		SpawnEnemy(x2, y2, Map.mapsize.x-2, 1, type)

func SpawnEnemy(x, y, x1, y1, type):
	if Map.Map[x1][y].type == "empty":
		AddEnemy(x1, y, type)
	elif Map.Map[x][y1].type == "empty":
		AddEnemy(x, y1, type)
	else:
		var x2 = rand_range(0, Map.mapsize.x)
		var y2 = rand_range(0, Map.mapsize.y)
		SpawnEnemy(x2, y2, x1, y1, type)

func AddEnemy(x, y, type):
	enemies_left += 1
	Enemies.append(HPvar.new())
	Enemies[len(Enemies)-1].HP = 50
	Enemies[len(Enemies)-1].pos = Vector2(x, y)
	Enemies[len(Enemies)-1].Scene = Goblin.instance()
	Enemies[len(Enemies)-1].Scene.SetType(type)
	Enemies[len(Enemies)-1].Scene.pos = Vector2(x, y)
	Enemies[len(Enemies)-1].Scene.id = len(Enemies)-1
	Enemies[len(Enemies)-1].Scene.position = Enemies[len(Enemies)-1].pos * Map.mapoffset + Map.mappos
	$"../../YSort".add_child(Enemies[len(Enemies)-1].Scene)
	
func DamageEnemy(id):
	Variables.score += int(8 / Enemies[id].Scene.speed * 2)
	$"../../GUI".score(Variables.score)
	Enemies[id].HP -= Variables.playerattack
	Enemies[id].Scene.ChangeHP(Enemies[id].HP)
	if Enemies[id].HP < 1:
		var tmp = corpse.instance()
		tmp.position = Enemies[id].Scene.position
		Enemies[id].Scene.queue_free()
		Enemies[id] = null
		$"../../Corpses".add_child(tmp)
		enemies_left -= 1
	
	if enemies_left < 1:
		Variables.ResetMap()

func Hit(new):
	$"../../GUI/".Hit()
	Variables.HP += new
	if Variables.HP > 100:
		Variables.HP = 100
	if Variables.HP < 1:
		Variables.GameOver()