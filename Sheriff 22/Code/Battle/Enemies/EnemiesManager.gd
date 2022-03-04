extends YSort

export(NodePath) var MapNavigationPath
onready var MapNavigation = get_node(MapNavigationPath)

export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

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
export(NodePath) var PlantsPath
onready var Plants = get_node(PlantsPath)


func SpawnEnemy(x, y, enemy):
	var tmp = enemy.instance()
	tmp.global_position = Vector2(x, y)
	add_child(tmp)
	if !is_instance_valid(GUI):
		GUI = get_node(GUIPath)
	GUI.SpawnEnemy()

func SpawnPlant(x, y, plant):
	var tmp = plant.instance()
	tmp.global_position = Vector2(x, y)
	Plants.add_child(tmp)
