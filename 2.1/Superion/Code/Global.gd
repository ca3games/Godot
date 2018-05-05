extends Node2D

var level
var score

func _ready():
	level = 1
	score = 0

func _EnemyDead():
	get_tree().get_root().get_node("Node2D/SCORE")._enemydead()