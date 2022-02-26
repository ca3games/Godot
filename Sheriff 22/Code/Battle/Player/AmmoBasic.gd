extends Area2D

export(int) var ammo_stored


func _on_AmmoBasic_body_entered(body):
	if body.is_in_group("PLAYER"):
		body.ReloadAmmo(ammo_stored)
		self.queue_free()
