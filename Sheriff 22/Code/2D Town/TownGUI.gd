extends CanvasLayer

var end = false
export(String) var Battle = "res://Scenes/Battle/Maps/Roguelite/Level1.tscn"

func _ready():
	$GUI.show()
	$GUI/Revolver/AmmoBasic.text = str(Variables.GetAmmo(Variables.currentgun))
	$GUI/Lifebar.max_value = Variables.max_hp
	$GUI/Lifebar.value = Variables.HP
	StartTransition()
	
func StartTransition():
	get_tree().paused = true
	$GUI/Tween.interpolate_property($GUI/Screentone.material, "shader_param/position", -1.5, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$GUI/Tween.start()

func _on_Tween_tween_all_completed():
	if end:
		get_tree().change_scene(Battle)
	get_tree().paused = false


func EndTransition():
	end = true
	get_tree().paused = true
	$GUI/Tween.interpolate_property($GUI/Screentone.material, "shader_param/position", 1, -1.5, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$GUI/Tween.start()
