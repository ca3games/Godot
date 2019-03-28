extends Node2D

func _on_Button_pressed():
	if !$Start.playing:
		$Start.play()

func _change():
	get_tree().change_scene("res://Scenes/GameScreen/Dificulty.tscn")


func _Hover():
	if !$Hover.playing:
		$Hover.play()
