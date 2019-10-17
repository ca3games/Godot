extends Node2D

func _ready():
	if !Variables.winner:
		$name.text = "SOFI"
	else:
		$name.text = "CAMMY"
