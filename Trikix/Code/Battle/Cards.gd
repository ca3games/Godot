extends Node2D

var type
var button = false
var pos

func _ready():
	$AnimatedSprite.frame = type

func HideRed():
	$red.hide()

func ShowRed():
	$red.show()

func _on_Button_pressed():
	if button:
		$"../../Map".ButtonTouch()
	else:
		$"../../Map".MapClick(pos.x, pos.y)

func ChangeType(new):
	type = new
	$AnimatedSprite.frame = type

func _on_Button_mouse_entered():
	if !button:
		$"../".ResetRed()
		ShowRed()
