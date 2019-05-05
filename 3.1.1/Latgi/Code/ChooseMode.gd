extends Node2D

func _on_Human_pressed():
	Variables.type = Variables.typemode.human
	get_tree().change_scene("res://Scene/Map.tscn")


func _on_AI_pressed():
	Variables.type = Variables.typemode.ai
	get_tree().change_scene("res://Scene/Map.tscn")


func _on_Online_pressed():
	get_tree().change_scene("res://Scene/Lobby.tscn")
