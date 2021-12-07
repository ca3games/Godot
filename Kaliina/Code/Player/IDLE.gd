extends "res://Code/Player/BasicState.gd"

export(Vector2) var offset

func Update(delta):
	Walk()
	FarmInput(offset)
