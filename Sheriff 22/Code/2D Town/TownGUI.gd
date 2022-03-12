extends CanvasLayer

func _ready():
	$GUI.show()
	StartTransition()
	
func StartTransition():
	get_tree().paused = true
	$GUI/Tween.interpolate_property($GUI/Screentone.material, "shader_param/position", -1.5, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$GUI/Tween.start()

func _on_Tween_tween_all_completed():
	get_tree().paused = false
