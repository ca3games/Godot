extends Area2D



func _on_PlayerBullet_body_entered(body):
	if body.is_in_group("ENEMY"):
		body.HIT($"../".damage)
	$"../".queue_free()
