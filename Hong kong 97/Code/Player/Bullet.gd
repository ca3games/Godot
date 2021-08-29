extends KinematicBody2D

export(float) var Speed

onready var score = rand_range(3, 20)
export(PackedScene) var Dead01
export(PackedScene) var Dead02

func _physics_process(delta):
	var colision = move_and_collide(Vector2.UP * Speed * delta)
	
	if colision:
		if colision.collider.is_in_group("ENEMY") and !colision.collider.is_in_group("ENEMY02"):
			Variables.ChangeScore(score)
			var tmp = Dead01.instance()
			tmp.position = colision.collider.position
			$"../".add_child(tmp)
			colision.collider.SpawnDead()
			colision.collider.queue_free()
			self.queue_free()
		if colision.collider.is_in_group("ENEMY02"):
			Variables.ChangeScore(score)
			var tmp = Dead02.instance()
			tmp.position = colision.collider.position
			$"../".add_child(tmp)
			colision.collider.SpawnDead()
			colision.collider.queue_free()
			self.queue_free()
		if colision.collider.is_in_group("BOSS"):
			colision.collider.Hit()
			if colision.collider.HP < 1:
				colision.collider.Die()
			Variables.ChangeScore(100)
			self.queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
