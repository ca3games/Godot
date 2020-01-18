extends Node2D



func _ready():
	if Variables.type != Variables.typemode.ai:
		$Champion.text = "P1 won" if Variables.P1won else "P2 won"
	else:
		$Champion.text = "P1 won" if Variables.P1won else "CPU won"
		



func _on_RETURN_pressed():
	get_tree().change_scene("res://Scene/Title.tscn")
