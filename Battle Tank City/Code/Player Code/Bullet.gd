extends KinematicBody

var direction = Vector2.ZERO
var speed = 10

func _physics_process(delta):
	var dir = direction * speed * delta
	var collision = move_and_collide(Vector3(dir.x, 0, dir.y))
	
	if collision:
		if collision.collider.is_in_group("Enemy"):
			collision.collider.queue_free()
			self.queue_free()
			$"../Player".idle = true
		
		if collision.collider.is_in_group("Brick"):
			$"../Player".idle = true
			collision.collider.Change_HP()
			self.queue_free()
		
		if collision.collider.is_in_group("Boss"):
			$"../Player".idle = true
			collision.collider.Change_HP()
			self.queue_free()
		
		
		if collision.collider.is_in_group("Water"):
			$"../Player".idle = true
			self.queue_free()
