extends Node2D

export(NodePath) var FSMPath
onready var FSM = get_node(FSMPath)

var stop = 1.5
var points = []

var flocking = 0

func Physics(delta):
	var playerpos 
	playerpos = FSM.Root.get_parent().Player.global_position - (FSM.Root.startingpos / 10)
	points = FSM.Root.get_parent().MapNavigation.get_simple_path(FSM.Root.global_position, playerpos)
	
	if points.size() > 1:
		var distance = points[1] - FSM.Root.get_global_position()
		var direction = distance.normalized()
		if distance.length() > stop or points.size() > 2:
			FSM.Root.move_and_collide(direction * FSM.Root.vel * delta)
