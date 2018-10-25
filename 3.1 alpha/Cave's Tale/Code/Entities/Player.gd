extends Spatial

var map
onready var TweenNode = get_node("Tween")
var finished
enum direction {up, down, left, right, none}
var direccion = direction.up

func _ready():
	#Get node from Map generator on 3DMap.tscn
	map = get_node("../../")
	
	finished = true
	var Playerpos = map._getPlayerCoord()
	_move(0,0,0)
	map._turnRed(Playerpos.x, Playerpos.y)

func _input(event):
	direccion = direction.none
	if finished:
		if Input.is_action_pressed("LEFT"):
			direccion = direction.left
		if Input.is_action_pressed("RIGHT"):
			direccion = direction.right
		if Input.is_action_pressed("UP"):
			direccion = direction.up
		if Input.is_action_pressed("DOWN"):
			direccion = direction.down
		
		match(direccion):
			direction.up:
				_move(0, 1, 8)
			direction.down:
				_move(0, -1, 2)
			direction.left:
				_move(-1, 0, 4)
			direction.right:
				_move(1, 0, 6)
	
func _move(x, y, d):
	var Playerpos = map._getPlayerCoord()
	if map._Valid(Playerpos.x + x, Playerpos.y + y):
		map._turnRed(Playerpos.x + x, Playerpos.y + y)
		map._turnWhite(Playerpos.x, Playerpos.y)
		map._moveplayer(x, y)
		map._cameraboundary()
		TweenNode.interpolate_property(self, "translation", map._getPos(Playerpos.x, Playerpos.y) , map._getPlayerpos(), 0.3, Tween.TRANS_LINEAR,Tween.EASE_IN)
		TweenNode.start()
		finished = false
	if map._IsWall(Playerpos.x + x, Playerpos.y + y):
			map._TextWall(d)
	map._GroundInfo(map._getPlayerCoord().x, map._getPlayerCoord().y)


func _tween_completed(object, key):
	finished = true
