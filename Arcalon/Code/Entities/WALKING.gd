extends "res://Code/Entities/BASE_STATE.gd"

func Physics(delta):
	var speed = FSM.Direction * FSM.speed * delta
	
	var collision = FSM.Root.move_and_collide (speed)
	if collision:
		if collision.collider.is_in_group("V_WALL"):
			FSM.Direction.y *= -1
		if collision.collider.is_in_group("H_WALL"):
			FSM.Direction.x *= -1
		if collision.collider.is_in_group("ENEMYBULLET"):
			$"../../".Hit()
			collision.collider.queue_free()
