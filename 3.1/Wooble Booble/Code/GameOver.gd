extends Node2D

func _ready():
	$Score.text = str(int(Variables.score))
	Variables.level = 0


func _on_Button_pressed():
	Variables.Select()
	get_tree().change_scene("res://Scenes/Title.tscn")
