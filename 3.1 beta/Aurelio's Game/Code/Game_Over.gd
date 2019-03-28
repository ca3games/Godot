extends Node2D

func _ready():
	$Score.text = str(int(Variables.score))

func _on_Button_pressed():
	if !$Start.playing:
		$Start.play()


func _hover():
	if !$Hover.playing:
		$Hover.play()


func _Start():
	get_tree().change_scene("res://Scenes/GameScreen/Title.tscn")
