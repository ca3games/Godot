extends Node2D

func _on_TextureButton_pressed():
	$Button.disabled = true
	$"../Map".bomb_active = true
