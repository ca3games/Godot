extends Node2D

var HP = 100
var gameover = false

onready var bullet = preload("res://Scenes/Objects/Fireball.tscn")

func _ready():
	Hit(0)
	Variables.SetScore(0)
	$FADE.fadeOut()
	
func Hit(damage):
	HP -= damage
	$GUI/HP.value = HP
	
	if HP < 1 and gameover == false:
		$GUI.Hide()
		gameover = true
		$FADE.gameover = true
		$FADE.fadeIn()

func Heal(points):
	HP += points
	if HP > 100:
		HP = 100
	$GUI/HP.value = HP

func Bounce(mana):
	$GUI/Mana.value += mana
	$Camera2D.Bounce()
	
func Crash():
	$MUSIC/Crash.play()
	$Enemies.Killed()


func _on_Health_pressed():
	Heal(10)
	$GUI/Mana.value -= 40
	

func _on_Switch_pressed():
	$Ball.Switch()
	$GUI/Mana.value -= 25
	

func _on_Spell_pressed():
	var tmp = bullet.instance()
	tmp.position = $Ball.position
	$BULLETS.add_child(tmp)
	
	$GUI/Mana.value -= 15


func _on_TimeTimer_timeout():
	Hit(5000)


func _on_Reset_timeout():
	$Enemies.Reset()
