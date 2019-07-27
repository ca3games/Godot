extends AnimatedSprite

var pos


func _on_Area2D_area_entered(area):
	if area.is_in_group("Hero"):
		$"../../Scripts/Map".CleanGrass()
		$"../../Scripts/Variables".Player.pos = pos
	
	if area.is_in_group("Enemy"):
		area.get_parent().pos = pos
	
	if area.is_in_group("Waifu"):
		area.get_parent().pos = pos
