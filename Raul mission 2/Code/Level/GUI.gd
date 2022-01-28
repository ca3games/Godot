extends CanvasLayer

func _ready():
	UpdateHP()

func UpdateHP():
	$VBoxContainer/HBoxContainer/HP.text = str(Variables.HP)

func WALKMANA():
	$VBoxContainer/Mana.value += 1

func GetMANA():
	return $VBoxContainer/Mana.value

func SetMANA(bomb_cost):
	$VBoxContainer/Mana.value -= bomb_cost
