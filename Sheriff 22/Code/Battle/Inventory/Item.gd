extends Control

onready var gun = -999
onready var id = 0

export(Color) var Selected
export(Color) var transparent
export(Color) var active


func _ready():
	SelectOFF()

func SelectON():
	SetColor(Selected)

func SelectOFF():
	SetColor(transparent)

func SetActive():
	SetColor(active)

func SetItem(g):
	gun = g
	
	
func SetColor(c):
	$Selection.theme.get("Panel/styles/panel").set("border_color", c)

func UpdatePic():
	if gun == -999:
		$AnimatedSprite.frame = 0
	else:
		$AnimatedSprite.frame = Variables.GetGun(gun)+1
	var ammo = Variables.GetAmmo(gun)
	if ammo != -999:
		if ammo == null:
			$AMMO.text = ""
		else:
			$AMMO.text = str(ammo)
	else:
		$AMMO.text = ""
