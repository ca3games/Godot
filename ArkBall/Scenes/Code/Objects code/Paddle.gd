extends KinematicBody2D

var vel = 8

func _input(event):
	if event is InputEventScreenDrag:
		if event.relative.x > 0:
			self.move_and_collide(Vector2(vel, 0))
		elif event.relative.x < 0:
			self.move_and_collide(Vector2(-vel, 0))
