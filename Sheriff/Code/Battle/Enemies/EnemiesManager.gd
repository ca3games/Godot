extends YSort

export(NodePath) var MapNavigationPath
onready var MapNavigation = get_node(MapNavigationPath)

export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

export(PackedScene) var Enemy01
export(NodePath) var LeftUpPath
onready var LeftUp = get_node(LeftUpPath)
export(NodePath) var RightDownPath
onready var RightDown = get_node(RightDownPath)

export(NodePath) var GUIPath
onready var GUI = get_node(GUIPath)
export(NodePath) var PlayerBulletsPath
onready var PlayerBullets = get_node(PlayerBulletsPath)
export(NodePath) var EnemyBulletPath
onready var EnemyBullet = get_node(EnemyBulletPath)

func _ready():
	var id = (Variables.level / 3) + 3
	SpawnEnemies(id * Variables.dificulty)


func SpawnEnemies(x):
	for i in x:
		SpawnEnemy()

func SpawnEnemy():
	var tmp = Enemy01.instance()
	var x = rand_range(LeftUp.global_position.x, RightDown.global_position.x)
	var y = rand_range(LeftUp.global_position.y, RightDown.global_position.y)
	tmp.global_position = Vector2(x, y)
	add_child(tmp)
	GUI.SpawnEnemy()
	
