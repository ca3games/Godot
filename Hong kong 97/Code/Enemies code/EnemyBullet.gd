extends KinematicBody2D

export(float) var Speed

onready var score = rand_range(3, 20)

func _physics_process(delta):
	var colision = move_and_collide(Vector2.DOWN * Speed * delta)
	
	if colision:
		if colision.collider.is_in_group("PLAYER"):
			Variables.GameOver()


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
