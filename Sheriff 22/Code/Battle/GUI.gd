extends CanvasLayer

export(bool) var nextprocgen
export(bool) var setprocgenmax
export(int) var procgennextMax  #How much times the proc gen will reset before using NextScene
export(String) var NextProcGen
export(int) var SwitchId
var left = 1  #Enemies left
var gameover = false
var shop = "res://Scenes/Shop/SHOP.tscn"


export(String) var NextScene 
export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)
onready var inventory = false
export(NodePath) var EnemyManagerPath
onready var EnemyManager = get_node(EnemyManagerPath)
export(NodePath) var SoundsPath
onready var Sounds = get_node(SoundsPath)

func _ready():
	yield(get_tree(), "idle_frame")
	left = EnemyManager.get_child_count()
	$GUI/VBoxContainer/LEFT.text = "LEFT : " + str(left)
	$GUI/VBoxContainer/LEVEL.text = "LEVEL : " + str(Variables.level)
	
	$GUI.show()
	inventory = false
	$GUI/MONEY.text = "GOLD : " + str(Variables.money)
	$GUI/Lifebar.max_value = Variables.max_hp
	$GUI/Lifebar.value = Variables.HP
	$GUI/VBoxContainer/WAVE.text = "WAVE : " + str(Variables.wave)
	$GUI/Screentone.material.set("shader_param/position", -1.5)
	UpdateScore()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	StartTransition()

func SetAmmoBasic(x):
	if x == -999:
		$GUI/Revolver/AmmoBasic.text = str(0)
	else:
		$GUI/Revolver/AmmoBasic.text = str(x)

func SpawnEnemy():
	left += 1
	$GUI/VBoxContainer/LEFT.text = "LEFT : " + str(left)

func EnemyDie():
	left -= 1
	$GUI/VBoxContainer/LEFT.text = "LEFT : " +  str(left)
	if left < 1:
		gameover = true
		Sounds.ChangeLevel()
		$GUI/GameEnd.start(1.5)

func StartTransition():
	get_tree().paused = true
	$GUI/Tween.interpolate_property($GUI/Screentone.material, "shader_param/position", -1.5, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$GUI/Tween.start()

func EndTransition():
	get_tree().paused = true
	$GUI/Tween.interpolate_property($GUI/Screentone.material, "shader_param/position", 1, -1.5, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$GUI/Tween.start()

func DamageLifebar(damage):
	$GUI/Lifebar.value += damage

func UpdateScore():
	$GUI/SCORE.text = "SCORE " + str(Variables.score)


func _on_Tween_tween_all_completed():
	if gameover:
		if Variables.WinWave():
			get_tree().change_scene(shop)
		else:
			get_tree().change_scene(NextScene)
	get_tree().paused = false

func UpdateMoney():
	$GUI/MONEY.text = "GOLD : " + str(Variables.money)

func Update():
	$GUI/INVENTORY.RESET()

func _on_GameEnd_timeout():
	EndTransition()
