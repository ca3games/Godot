extends Area2D

export(int) var type


func _on_RevolverItem_body_entered(body):
	if body.is_in_group("PLAYER"):
		Variables.AddGun(Vector2(type, 50))
		body.GUI.Update()
		self.queue_free()
