extends "res://Code/Players/BasicState.gd"

func Update(delta):
	
	var direction = Vector2.ZERO
	var left = false
	var right = false
	var up = false
	var down = false
	
	if Input.is_action_pressed(FSM.sLEFT):
		left = true
	if Input.is_action_pressed(FSM.sRIGHT):
		right = true
	if Input.is_action_pressed(FSM.sUP):
		up = true
	if Input.is_action_pressed(FSM.sDOWN):
		down = true
	
	if left and !right and !up and !down:
		direction.x = -1
	if right and !left and !up and !down:
		direction.x = 1
	if up and !down and !left and !right:
		direction.y = -1
	if down and !up and !left and !right:
		direction.y = 1
	
	FSM.direction = direction
	
	if not direction != Vector2.ZERO:
		FSM.ChangeState("IDLE")

func Physics(delta):
	
	var speed = FSM.direction * FSM.vel
	
	FSM.Root.move_and_collide(Vector3(speed.x*delta, 0, speed.y*delta))
	
	var y = 0
	
	match (FSM.direction):
		Vector2(-1, 0): y = 180
		Vector2(1, 0): y = 0
		Vector2(0, 1): y = 270
		Vector2(0, -1): y = 90
	
	FSM.Root.rotation_degrees.y = y
