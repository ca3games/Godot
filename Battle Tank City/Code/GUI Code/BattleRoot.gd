extends Node2D

onready var Battle_World = preload("res://Scenes/Battle.tscn")

func _ready():
	var tmp = Battle_World.instance()
	$ViewportContainer/Viewport.add_child(tmp)

func Reload():
	$ViewportContainer/Viewport.get_child(0).queue_free()	
	var tmp = Battle_World.instance()
	$ViewportContainer/Viewport.add_child(tmp)
