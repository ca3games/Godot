extends Node2D

func _ready():
	UpdateMoney()
	
func UpdateMoney():
	$MONEYTEXT.text = str(Variables.money)


func _on_Next_button_up():
	var scene = "res://Scenes/Battle/Maps/Roguelite/Level1.tscn"
	get_tree().change_scene(scene)

func BuyAmmo(price, gift):
	if Variables.money >= price:
		Variables.ammo += gift
		Variables.money -= price
		UpdateMoney()

func BuyHP(price, gift):
	if Variables.money >= price:
		Variables.AddHP(gift)

func _on_20ammo_button_up():
	BuyAmmo(50, 20)

func _on_50ammo_button_up():
	BuyAmmo(150, 50)

func _on_99ammo_button_up():
	BuyAmmo(250, 99)

func _on_500freecoins_button_up():
	Variables.money += 500
	UpdateMoney()


func _on_20hp_button_up():
	BuyHP(100, 20)


func _on_50hp_button_up():
	BuyHP(250, 50)


func _on_99hp_button_up():
	BuyHP(400, 99)


func _on_gunlevelup_button_up():
	if Variables.money >= 800:
		Variables.money -= 800
		Variables.gunlevel += 1
		UpdateMoney()



func _on_kicklevelup_button_up():
	if Variables.money >= 500:
		Variables.money -= 500
		Variables.kicklevel += 1
		UpdateMoney()
