extends Node2D

export(String) var Title

func _ready():
	$SCORE.text = str(Variables.score)
	$MAXSCORE.text = str(Variables.MaxSCORE)


func _on_Button_pressed():
	get_tree().change_scene(Title)
