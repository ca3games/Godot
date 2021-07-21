extends Spatial

func _on_BasicEnemy_body_entered(body):
	if body.is_in_group("ENEMY"):
		match($"../../".last_hit):
			"PLAYER": $"../COLORS".HIT()
			"GUINEA": $"../COLORS".GuineaHIT()
		
	
	if body.is_in_group("HOUSE"):
		if $"../COLORS".HP == $"../COLORS".MaxHP:
			$"../DIE".DIE()
	
	if body.is_in_group("GUINEA"):
		$"../../".last_hit = "GUINEA"
		if $"../COLORS".HP == -$"../COLORS".MaxHP:
			$"../DIE".GuineaDIE()
