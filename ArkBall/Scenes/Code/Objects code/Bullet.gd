extends KinematicBody2D

var angle
var speed = 5

func _ready():
	var paddle = get_tree().get_root().get_node("Root/Paddle").position
	angle = paddle - position
	angle = angle.normalized()
	angle *= speed

func _physics_process(delta):
	self.move_and_collide(angle)


func _on_Area2D_body_entered(body):
	if body.is_in_group("PADDLE"):
		get_tree().get_root().get_node("Root").Hit(5)
		self.queue_free()
	
	if body.is_in_group("WALL"):
		self.queue_free()
