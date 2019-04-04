extends Node2D

func _ready():
	$Score.text = str(int(Variables.score))


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Title.tscn")
