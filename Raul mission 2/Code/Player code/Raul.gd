extends KinematicBody2D

var menushown = false

onready var GUI = get_tree().get_root().get_node("BattleWrap").find_node("GUI")

export (NodePath) var SceneRootPath
onready var SceneRoot = get_node(SceneRootPath)
