extends Node2D

var HP = 100
var dificulty = 1
onready var max_hp = HP
var wave = 0
var level = 1
var kicklevel = 1
var gunlevel = 1
var money = 0
var ammo = 50
var currentgun = 0
var score = 0

onready var GameOverScreen = "res://Scenes/Story/GameOver.tscn"

func _ready():
	ResetVariables()

func WinWave():
	wave += 1
	if wave > 3:
		wave = 0
		level += 1
		return true
	return false


func ResetVariables():
	HP = 100
	max_hp = HP
	wave = 0
	dificulty = 1
	kicklevel = 1
	gunlevel = 1
	level = 1
	ammo = 50
	currentgun = 0
	score = 0


func AddAmmo(amount):
	ammo += amount

func ConsumeAmmo():
	ammo -= 1
	if ammo < 1:
		ammo = 0

func GetAmmo():
	return ammo

func AddScore(newscore):
	score += int(newscore)

func AddHP(newhp):
	HP += newhp
	if HP >= max_hp:
		HP = max_hp

func PlayerDamage(damage):
	HP -= damage
	if HP < 1:
		$"/root/Battle/Sounds".StopBattleSong()
		get_tree().change_scene(GameOverScreen)
