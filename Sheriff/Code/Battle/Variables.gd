extends Node2D

var HP = 1000
var dificulty = 1
onready var max_hp = HP
var level = 0
var wave = 0
var ammobasic = 100

onready var GameOverScreen = "res://Scenes/Story/GameOver.tscn"


func WinWave():
	wave += 1
	if wave > 5:
		wave = 0
		level += 1

func ResetVariables():
	HP = 1000
	max_hp = HP
	level = 0
	wave = 0
	ammobasic = 100
	dificulty = 1


func PlayerDamage(damage):
	HP -= damage
	if HP < 1:
		Sounds.StopBattleSong()
		get_tree().change_scene(GameOverScreen)
