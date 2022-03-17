extends Node2D

var HP = 1000
var dificulty = 1
onready var max_hp = HP
var wave = 0
var boardwave = 0
var level = 1
var kicklevel = 1
var money = 0
var guns = []
var currentgun = 0

enum guntype {revolver}

onready var GameOverScreen = "res://Scenes/Story/GameOver.tscn"

func _ready():
	ResetVariables()

func WinWave():
	wave -= 1

func EndBattle():
	boardwave += 1
	if boardwave > 3:
		boardwave = 0
		level += 1

func ResetVariables():
	HP = 1000
	max_hp = HP
	wave = 0
	dificulty = 1
	money = 0
	guns = []
	AddGun(Vector2(guntype.revolver, 50))


func TownReset():
	HP += 500
	max_hp = 1000
	wave = 0
	dificulty = 1
	NewAmmoTownReset()

func NewAmmoTownReset():
	for i in len(guns):
		if guns[i].x == guntype.revolver:
			guns[i].y += 50
			if guns[i].y > 99:
				guns[i].y = 99
			return
	AddGun(Vector2(guntype.revolver, 50))

func AddGun(id):
	if len(guns) < 5:
		guns.append(id)

func GunsMax():
	return len(guns)

func AddAmmo(id, amount):
	guns[id].y += amount
	if guns[id].y > 99:
		guns[id].y = 99

func ConsumeAmmo():
	guns[currentgun].y -= 1
	if guns[currentgun].y < 1:
		guns[currentgun].y = 0

func GetAmmo(id):
	if id == -999:
		return
	return guns[id].y

func GetGun(id):
	return guns[id].x


func PlayerDamage(damage):
	HP -= damage
	if HP < 1:
		$"/root/Battle/Sounds".StopBattleSong()
		get_tree().change_scene(GameOverScreen)
