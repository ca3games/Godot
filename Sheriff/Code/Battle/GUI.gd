extends CanvasLayer

var left = 0
var gameover = false

onready var battle_scene = "res://Scenes/Battle/Battle.tscn"
export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

func _ready():
	$Lifebar.max_value = Variables.max_hp
	$Lifebar.value = Variables.HP
	$VBoxContainer/LEVEL.text = "LEVEL : " + str(Variables.level)
	$VBoxContainer/WAVE.text = "WAVE : " + str(Variables.wave)
	$Screentone.material.set("shader_param/position", -1.5)
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	StartTransition()

func SetAmmoBasic(x):
	$Revolver/AmmoBasic.text = str(x)

func SpawnEnemy():
	left += 1
	$VBoxContainer/LEFT.text = "LEFT : " + str(left)

func EnemyDie():
	left -= 1
	$VBoxContainer/LEFT.text = "LEFT : " +  str(left)
	if left < 1:
		gameover = true
		Sounds.ChangeLevel()
		$GameEnd.start(1.5)

func StartTransition():
	get_tree().paused = true
	$Tween.interpolate_property($Screentone.material, "shader_param/position", -1.5, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func EndTransition():
	get_tree().paused = true
	$Tween.interpolate_property($Screentone.material, "shader_param/position", 1, -1.5, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func DamageLifebar(damage):
	$Lifebar.value += damage


func _on_Tween_tween_all_completed():
	if gameover:
		Variables.WinWave()
		Variables.ammobasic = Player.AmmoBasic
		get_tree().change_scene(battle_scene)
	else:
		get_tree().paused = false


func _on_GameEnd_timeout():
	EndTransition()
