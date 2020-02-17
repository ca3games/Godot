extends KinematicBody2D

var speed = Vector2(0, -10)

func _physics_process(delta):
	move_and_collide(speed)


func _on_Area2D_body_entered(body):
	if body.is_in_group("TOP"):
		self.queue_free()
	if body.is_in_group("ENEMY"):
		body.Hit(5000)
		self.queue_free()
