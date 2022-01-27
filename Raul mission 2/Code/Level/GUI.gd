extends Control

func _ready():
	UpdateHP()

func UpdateHP():
	$Label/HP.text = str(Variables.HP)

func WALKMANA():
	$Mana.value += 1

func GetMANA():
	return $Mana.value

func SetMANA(bomb_cost):
	$Mana.value -= bomb_cost
