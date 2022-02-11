extends "res://Code/Battle/Enemies/BASE STATE.gd"
	
var stop = 1.5
var points = []

var flocking = 0

func Physics(delta):
	FSM.state_machine.travel("WALK")
	FSM.AnimTree.set("parameters/WALK/blend_position", FSM.direction)

	var playerpos 
	if flocking < 2 :
		playerpos = FSM.Root.get_parent().Player.global_position
	else:
		playerpos = FSM.Root.startingpos
	points = FSM.Root.get_parent().MapNavigation.get_simple_path(FSM.Root.global_position, playerpos)
	
	if points.size() > 1:
		FSM.direction = FSM.GetDirAngle()
		var distance = points[1] - FSM.Root.get_global_position()
		var direction = distance.normalized()
		if distance.length() > stop or points.size() > 2:
			FSM.Root.move_and_collide(direction * FSM.vel * delta)
		
func _draw():
	if points.size() > 1:
		for p in points:
			FSM.Root.draw_circle(p - FSM.Root.get_global_position(), 8, Color.red)


func _on_FlockingAvoidance_body_entered(body):
	flocking += 1


func _on_FlockingAvoidance_body_exited(body):
	flocking -= 1
