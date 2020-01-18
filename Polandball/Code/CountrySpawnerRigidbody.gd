extends Node2D
onready var America = preload("res://Scenes/Polandballs/America.tscn")

func _ready():
	var tmp = America.instance()
	add_child(tmp)
	pass
