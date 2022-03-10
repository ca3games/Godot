extends YSort

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
