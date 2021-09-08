extends Node2D

onready var tween = $Tween

func _on_Button_pressed():
	tween.interpolate_property($ColorRect, "color", Color8(0,0,0,0), Color.black, 1, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	tween.start()




func _on_Tween_tween_completed(object, key):
	Variables.StartBattle()
