extends CanvasLayer

func _on_Time_Left_timeout():
	$Time_Bar.value += 1
	
	if $Time_Bar.value > 59:
		get_tree().change_scene("res://Scenes/Battle.tscn")
