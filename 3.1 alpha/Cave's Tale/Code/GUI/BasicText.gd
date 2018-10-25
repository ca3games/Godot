extends Node2D

onready var Info = get_node("../Info")
onready var Ground = get_node("../Ground")

func _Wall(direccion):
	match(direccion):
		8: Info.text = "Couldn't go forward, there's a wall"
		2: Info.text = "Couldn't go downward, there's a wall"
		6: Info.text = "Couldn't travel eastward, there's a wall"
		4: Info.text = "Couldn't travel west, there's a wall"
		0: Info.text = ""

func _ground(type):
	if Ground != null :
		match(type):
			"empty": 
				Ground.text = "Empty ground"
			"plant": 
				Ground.text = "There's some vegetation"
			"grass": 
				Ground.text = "You see grass"