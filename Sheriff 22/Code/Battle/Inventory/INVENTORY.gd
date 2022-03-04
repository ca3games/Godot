extends Node2D


func _ready():
	TURNOFF()

func TURNON():
	$"3D Guns".TURNON()

func TURNOFF():
	$"3D Guns".TURNOFF()
