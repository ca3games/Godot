extends KinematicBody2D

onready var Direction = Vector2.ZERO
export (float) var speed
export(bool) var Mine

func _ready():
	if !Mine:
		var pos = get_tree().get_root().get_node("Battle/Ball").position
		Direction = (pos - self.position).normalized()

func _physics_process(delta):
	if !Mine:
		var collision = move_and_collide(Direction * speed * delta)
		
		if collision:
			if collision.collider.is_in_group("WALL"):
				queue_free()
			
			if collision.collider.is_in_group("BALL"):
				collision.collider.Hit()
				queue_free()
