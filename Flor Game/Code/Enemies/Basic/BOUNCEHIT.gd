extends Spatial

func _on_BasicEnemy_body_entered(body):
	if body.is_in_group("ENEMY"):
		$"../COLORS".HIT()
	
	if body.is_in_group("HOUSE"):
		if $"../COLORS".HP == $"../COLORS".MaxHP:
			$"../DIE".DIE()
