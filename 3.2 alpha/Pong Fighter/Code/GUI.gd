extends Node2D

onready var P1HP = 100
onready var P2HP = 100

func _ready():
	$"P1 HP".value = P1HP
	$Mana.start(0.2)



func ChangeHP(p1, hp):
	if p1:
		P1HP += hp
		$"P1 HP".value = P1HP
	else:
		P2HP += hp
		$"P2 HP".value = P2HP
		
func ChangeMana(p1, mana):
	if p1:
		$"P1 Mana".value += mana
	else:
		$"P2 Mana".value += mana


func _on_Mana_timeout():
	$Mana.start(0.4)
	$"P1 Mana".value += 2
	$"P2 Mana".value += 2
