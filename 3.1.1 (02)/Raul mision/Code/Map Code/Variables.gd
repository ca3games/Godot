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
var last_enemyID
var max_enemies = 10

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
			SpawnEnemyOP("archer", false)
	var chance = randi()%3 + 1
	if chance < 2:
		SpawnEnemyOP("summoner", false)
		SpawnEnemyOP("white", true)
	else:
		SpawnEnemyOP("summoner", true)
		SpawnEnemyOP("white", false)

func SpawnEnemyOP(type, left):
	var x2 = rand_range(1, Map.mapsize.x-2)
	var y2 = rand_range(1, Map.mapsize.y-2)
	if left:
		SpawnEnemy(x2, y2, 1, 1, type, 0)
	else:
		SpawnEnemy(x2, y2, Map.mapsize.x-2, 1, type, 0)

func SpawnEnemy(x, y, x1, y1, type, id):
	if Map.Map[x1][y].type == "empty" and !PosOccupied(Vector2(x1, y)):
		AddEnemy(x1, y, type)
	elif Map.Map[x][y1].type == "empty" and !PosOccupied(Vector2(x, y1)):
		AddEnemy(x, y1, type)
	elif id < 20:
		var x2 = rand_range(0, Map.mapsize.x)
		var y2 = rand_range(0, Map.mapsize.y)
		SpawnEnemy(x2, y2, x1, y1, type, id + 1)
	else:
		var x2 = rand_range(0, Map.mapsize.x)
		AddEnemyRow2(x2, 2, type, 0)

func AddEnemyRow2(x, y, type, id):
	if Map.Map[x][y].type == "empty" and PosOccupied(Vector2(x, y)):
		AddEnemy(x, y, type)
	elif id < 20:
		var x2 = rand_range(0, Map.mapsize.x)
		AddEnemyRow2(x2, y, type, id + 1)
	else:
		var x2 = rand_range(0, Map.mapsize.x)
		AddEnemyRow2(x2, y+1, type, 0)

func PosOccupied(pos):
	for i in range(0, len(Enemies)):
		if Enemies[i].pos == pos:
			return true
	return false

func AddEnemy(x, y, type):
	if enemies_left >= max_enemies:
		return
	enemies_left += 1
	Enemies.append(HPvar.new())
	Enemies[len(Enemies)-1].HP = 30
	Enemies[len(Enemies)-1].pos = Vector2(x, y)
	Enemies[len(Enemies)-1].Scene = Goblin.instance()
	Enemies[len(Enemies)-1].Scene.SetType(type)
	Enemies[len(Enemies)-1].Scene.pos = Vector2(x, y)
	Enemies[len(Enemies)-1].Scene.id = len(Enemies)-1
	Enemies[len(Enemies)-1].Scene.position = Enemies[len(Enemies)-1].pos * Map.mapoffset + Map.mappos
	$"../../YSort".add_child(Enemies[len(Enemies)-1].Scene)
	
func DamageEnemy(id):
	last_enemyID = id
	if Enemies[id] != null:
		Variables.score += int(8 / Enemies[id].Scene.speed * 2)
	else:
		return
	$"../../GUI".score(Variables.score)
	Enemies[id].HP -= Variables.playerattack
	Enemies[id].Scene.ChangeHP(Enemies[id].HP)
	if Enemies[id].HP < 1:
		var tmp = corpse.instance()
		tmp.position = Enemies[id].Scene.position
		tmp.pos = Enemies[id].Scene.dead_pos
		tmp.id = id
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
		Player.Scene.get_node("STATES/WALKING").dead = true
		Variables.GameOver()
		
func Heal():
	var id = GetSmallerHP()
	if id.x != 999:
		Enemies[id.x].HP += 15
		if Enemies[id.x].HP > 30:
			Enemies[id.x].HP = 30
		Enemies[id.x].Scene.get_node("TextureProgress").value = Enemies[id.x].HP
		Enemies[id.x].Scene.BeingHealed()
	
func GetSmallerHP():
	var id = Vector2(999, 999)
	for i in range(0, len(Enemies)):
		if Enemies[i] == null:
			continue
		if id.y >= Enemies[i].HP:
			id = Vector2(i, Enemies[i].HP)
	
	return id

func Revive():
	var corpses = $"../../Corpses".get_children()
	
	if corpses == null or len(corpses) <= 0:
		return
	var type
	var chance = randi()%4+1
	match(chance):
		1: type = "warrior"
		2: type = "archer"
		3: type = "summoner"
		4: type = "white"
		_: type = "warrior"
	
	corpses[0].get_node("Ring").show()
	corpses[0].get_node("Timer").start(1.5)
	yield(corpses[0].get_node("Timer"), "timeout")
	
	AddEnemy(corpses[0].pos.x, corpses[0].pos.y, type)
	$"../../Corpses".get_child(0).queue_free()