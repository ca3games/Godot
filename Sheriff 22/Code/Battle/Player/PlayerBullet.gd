extends Area2D



func _on_PlayerBullet_body_entered(body):
	if body.is_in_group("ENEMY"):
		Variables.AddScore($"../".damage)
		$"../../".GUI.UpdateScore()
		body.HIT($"../".damage * Variables.gunlevel)
	$"../".queue_free()
