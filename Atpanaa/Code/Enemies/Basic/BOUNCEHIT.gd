extends Spatial

export(NodePath) var RootPath
onready var Root = get_node(RootPath)

func _on_BasicEnemy_body_entered(body):
	if body.is_in_group("ENEMY"):
		match($"../../".last_hit):
			"PLAYER": $"../COLORS".HIT()
			"GUINEA": $"../COLORS".GuineaHIT(5)
			_: $"../COLORS".GuineaHIT(5)
	
	if body.is_in_group("BOSS"):
		$"../DIE".BossDie()
	
	if body.is_in_group("HOUSE"):
		if Root.HP == Root.MaxHP:
			$"../DIE".DIE()
	
	if body.is_in_group("GUINEA"):
		if Root.attacked and Root.HP > 0:
			body.Hit(Root.HP)
		else:
			$"../../".last_hit = "GUINEA"
			if Root.HP == -Root.MaxHP:
				$"../DIE".GuineaDIE()
