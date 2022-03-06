extends Control

onready var gun = -999

func _ready():
	SelectOFF()

func SelectON():
	$Selection.show()

func SelectOFF():
	$Selection.hide()

func SetItem(g):
	gun = g

func UpdatePic():
	if gun == -999:
		$AnimatedSprite.frame = 0
	else:
		$AnimatedSprite.frame = Variables.GetGun(gun)+1
	var ammo = Variables.GetAmmo(gun)
	if ammo != -999:
		$AMMO.text = str(ammo)
	else:
		$AMMO.text = ""
