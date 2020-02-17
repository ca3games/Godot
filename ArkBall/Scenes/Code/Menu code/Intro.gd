extends Node2D

var touched = false
var begin = false

func _ready():
	yield(get_tree(), "idle_frame")
	$Score.text = "SCORE " + str(Variables.score)
	$MaxScore.text = "MAX SCORE " + str(Variables.best_score)
	$Score.hide()
	$MaxScore.hide()
	$ColorRect/Tween.interpolate_property($ColorRect, "color", Color8(0,0,0,255), Color8(0,0,0,0), 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$ColorRect/Tween.start()
	yield($ColorRect/Tween, "tween_completed")
	$Score.show()
	$MaxScore.show()

func _input(event):
	
	if event is InputEventScreenTouch:
		if event.pressed:
			Variables.score = 0
			Variables.level = 1
			Variables.wave = 1
			touched = true
			$Score.hide()
			$MaxScore.hide()
			$ColorRect/Tween.interpolate_property($ColorRect, "color", Color8(0,0,0,0), Color8(0,0,0,255), 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			$ColorRect/Tween.start()


func _on_Tween_tween_all_completed():
	if touched:
		get_tree().change_scene("res://Scenes/Battle/Battle.tscn")
