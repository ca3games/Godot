extends YSort

export(Vector2) var HP
export(Vector2) var BossHP
export(Vector2) var Speed
export(Vector2) var IdleTimer
export(Vector2) var ChaseTimer

export(NodePath) var MapNavigationPath
onready var MapNavigation = get_node(MapNavigationPath)

export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

export(NodePath) var GUIPath
onready var GUI = get_node(GUIPath)
export(NodePath) var PlayerBulletsPath
onready var PlayerBullets = get_node(PlayerBulletsPath)
export(NodePath) var EnemyBulletPath
onready var EnemyBullet = get_node(EnemyBulletPath)
export(NodePath) var PlantManagerPath
onready var PlantManager = get_node(PlantManagerPath)

func SpawnEnemy(x, y, enemy, isboss = false):
	var p = enemy.instance()
	p.global_position = Vector2(x, y)
	if isboss:
		p.HP = rand_range(BossHP.x, BossHP.y)
	else: 
		p.HP = rand_range(HP.x, HP.y)
	p.level = int(rand_range(0, 11))
	p.speed = rand_range(Speed.x, Speed.y)
	p.idletimer = rand_range(IdleTimer.x, IdleTimer.y)
	p.chasetimer = rand_range(ChaseTimer.x, ChaseTimer.y)
	p.level = randi()%10
	
	if randi()%3 == 1:
		p.DropBasicAmmo = true
	add_child(p)


func SpawnPlant(x, y, plant):
	var p = plant.instance()
	p.global_position = Vector2(x, y)
	if randi()%4 == 3:
		if randi()%3 == 2:
			p.bigcoin = true
		else:
			p.basiccoin = true
	PlantManager.add_child(p)
