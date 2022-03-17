extends YSort

export(NodePath) var GUIPath
onready var GUI = get_node(GUIPath)

export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

export(NodePath) var MapPath
onready var MapNavigation = get_node(MapPath)

export(NodePath) var EnemyBulletsPath
onready var EnemyBulletsManager = get_node(EnemyBulletsPath)
