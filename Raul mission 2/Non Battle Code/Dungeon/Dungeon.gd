extends Node2D

onready var levelmanager = $"../../../"

func _ready():
	pass # Replace with function body.

func StartBattle():
	levelmanager.ChangeScene("BATTLE")


func _on_StartBattle_timeout():
	StartBattle()
