extends Node2D

func _Wall(direccion):
	$BasicText._Wall(direccion)
	
func _groundinfo(type):
	$BasicText._ground(type)