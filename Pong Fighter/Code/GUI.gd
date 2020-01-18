extends Node2D

onready var P1HP = 100
onready var P2HP = 100
onready var Leftball = false
onready var Rightball = false

func _ready():
	$"P1 HP".value = P1HP
	$Mana.start(0.2)
	$TimeLeft.start(60)
	$HPrecovery.start(1)


func _process(delta):
	$Time.text = str(int($TimeLeft.time_left))


func ChangeHP(p1, hp):
	if p1:
		P1HP += hp
		$"P1 HP".value = P1HP
	else:
		P2HP += hp
		$"P2 HP".value = P2HP
	
	if P1HP < 1:
		Variables.winner = true
		Variables.GameOver()
	if P2HP < 1:
		Variables.winner = false
		Variables.GameOver()
		
func ChangeMana(p1, mana):
	if p1:
		$"P1 Mana".value += mana
	else:
		$"P2 Mana".value += mana


func _on_Mana_timeout():
	$Mana.start(0.4)
	$"P1 Mana".value += 2
	$"P2 Mana".value += 2

func _on_Left_body_entered(body):
	if body.is_in_group("Ball"):
		Leftball = false


func _on_Left_body_exited(body):
	if body.is_in_group("Ball"):
		Leftball = true


func _on_Right_body_entered(body):
	if body.is_in_group("Ball"):
		Rightball = false

func _on_Right_body_exited(body):
	if body.is_in_group("Ball"):
		Rightball = true


func _on_HPrecovery_timeout():
	$HPrecovery.start(1)
	if Leftball and P1HP < 99:
		P1HP += 1
		$"P1 HP".value = P1HP
	if Rightball and P2HP < 99:
		P2HP += 1
		$"P2 HP".value = P2HP
