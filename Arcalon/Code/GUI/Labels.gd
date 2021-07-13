extends Node2D

export(NodePath) var EnemiesPath
onready var Enemies = get_node(EnemiesPath)
export(NodePath) var LeftLabelPath
onready var leftlabel = get_node(LeftLabelPath)
export(NodePath) var LevelsLabelPath
onready var LevelsLabel = get_node(LevelsLabelPath)
export(NodePath) var GUIHPPath
onready var GUIHP = get_node(GUIHPPath)

func _ready():
	yield(get_tree(), "idle_frame")
	var left = Enemies.get_child_count()
	leftlabel.text = str(left)
	LevelsLabel.text = str(Variables.Level)
	GUIHP.value = Variables.HP

func _process(delta):
	var left = Enemies.get_child_count()
	leftlabel.text = str(left)
	if left <= 0:
		Variables.HP = int(GUIHP.value)
		Variables.WinLevel()
	
	if GUIHP.value < 1:
		Variables.GameOver()
