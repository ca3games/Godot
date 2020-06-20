extends KinematicBody

var direction = Vector2.ZERO
var speed = 10
var iron = false
enum bullet_type {
	P1, P2, enemies
}

var type = bullet_type.enemies

func _physics_process(delta):
	var dir = direction * speed * delta
	var collision = move_and_collide(Vector3(dir.x, 0, dir.y))
	
	if collision:
		if collision.collider.is_in_group("Enemy"):
			collision.collider.queue_free()
			FreeP1()
		
		if collision.collider.is_in_group("Brick"):
			collision.collider.Change_HP()
			FreeP1()
		
		if collision.collider.is_in_group("Boss"):
			collision.collider.Change_HP()
			FreeP1()
		
		if collision.collider.is_in_group("Iron"):
			if iron:
				collision.collider.queue_free()
			FreeP1()
		
		if collision.collider.is_in_group("Water"):
			FreeP1()
		
		if collision.collider.is_in_group("Player"):
			if collision.collider.is_in_group("P1"):
				pass
			FreeP1()
			

#This functions frees the player idle variable so player
#can shoot again faster
func FreeP1():
	if type == bullet_type.P1:
		$"../Player".idle = true
	self.queue_free()

func SetPlayer(id):
	if id == 1:
		type = bullet_type.P1
	if id == 2:
		type = bullet_type.P2
