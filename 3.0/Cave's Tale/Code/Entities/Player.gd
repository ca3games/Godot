extends Spatial

var map
onready var TweenNode = get_node("Tween")
var finished

func _ready():
	#Get node from Map generator on 3DMap.tscn
	map = get_node("../../")
	
	finished = true
	var Playerpos = map._getPlayerCoord()
	map._turnRed(Playerpos.x, Playerpos.y)

func _input(event):
	if finished:
		if Input.is_action_just_pressed("LEFT"):
			_move(-1, 0)
		if Input.is_action_just_pressed("RIGHT"):
			_move(1, 0)
		if Input.is_action_just_pressed("UP"):
			_move(0, 1)
		if Input.is_action_just_pressed("DOWN"):
			_move(0, -1)
	
func _move(x, y):
	var Playerpos = map._getPlayerCoord()
	if map._Valid(Playerpos.x + x, Playerpos.y + y):
		map._turnRed(Playerpos.x + x, Playerpos.y + y)
		map._turnWhite(Playerpos.x, Playerpos.y)
		map._moveplayer(x, y)
		TweenNode.interpolate_property(self, "translation", map._getPos(Playerpos.x, Playerpos.y) , map._getPlayerpos(), 0.3, Tween.TRANS_LINEAR,Tween.EASE_IN)
		TweenNode.start()
		finished = false


func _tween_completed(object, key):
	finished = true
