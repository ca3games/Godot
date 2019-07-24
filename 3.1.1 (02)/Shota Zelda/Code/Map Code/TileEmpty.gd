extends AnimatedSprite

var pos


func _on_Area2D_area_entered(area):
	if area.is_in_group("Hero"):
		$"../../Scripts/Map".CleanGrass()
		modulate = Color.red
