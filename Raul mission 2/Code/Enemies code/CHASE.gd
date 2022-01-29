extends "res://Code/Enemies code/BASE STATE.gd"
	
var stop = 1.5
var points = []
	
func Physics(delta):
	var playerpos = FSM.Root.get_parent().Player.global_position
	points = FSM.Root.get_parent().MapNavigation.get_simple_path(FSM.Root.global_position, playerpos)
	
	if points.size() > 1:
		var distance = points[1] - FSM.Root.get_global_position()
		var direction = distance.normalized()
		if distance.length() > stop or points.size() > 2:
			FSM.Root.move_and_collide(direction * FSM.vel * delta)
		
func _draw():
	if points.size() > 1:
		for p in points:
			FSM.Root.draw_circle(p - FSM.Root.get_global_position(), 8, Color.red)
