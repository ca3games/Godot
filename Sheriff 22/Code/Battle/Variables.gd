extends Node2D

var HP = 1000
var dificulty = 1
onready var max_hp = HP
var level = 0
var wave = 0
var kicklevel = 1
var money = 0
var guns = []
var ammo = []
var currentgun = 0

enum guntype {revolver}

onready var GameOverScreen = "res://Scenes/Story/GameOver.tscn"

func _ready():
	ResetVariables()

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
	dificulty = 1
	money = 0
	guns = []
	AddGun(guntype.revolver)
	AddAmmo(0, 99)

func AddGun(id):
	guns.append(id)

func GunsMax():
	return len(guns)

func AddAmmo(id, amount):
	if HasAmmo(id):
		for i in len(ammo):
			if id == ammo[i].x:
				ammo[i].y += amount
				if ammo[i].y > 99:
					ammo[i].y = 99
	else:
		ammo.append(Vector2(id, amount))

func ConsumeAmmo(id):
	if HasAmmo(id):
		for i in len(ammo):
			if id == ammo[i].x:
				ammo[i].y -= 1
				if ammo[i].y < 1:
					ammo.remove(i)

func GetAmmo(id):
	if HasAmmo(id):
		for i in len(ammo):
			if id == ammo[i].x:
				return ammo[i].y
	else:
		return -999

func GetGun(id):
	return guns[id]

func HasAmmo(id):
	for i in len(ammo):
		if id == ammo[i].x:
			return true
	return false

func PlayerDamage(damage):
	HP -= damage
	if HP < 1:
		$"/root/Battle/Sounds".StopBattleSong()
		get_tree().change_scene(GameOverScreen)
