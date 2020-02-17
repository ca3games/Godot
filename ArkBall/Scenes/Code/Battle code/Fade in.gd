extends ColorRect

var time = 1
var In = 0

var begin = true
var gameover = false

func fadeIn():
	$Tween.interpolate_property(self, "color", Color8(0,0,0,0), Color8(0,0,0,255), time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	In = 1
	
func fadeOut():
	$Tween.interpolate_property(self, "color", Color8(0,0,0,255), Color8(0,0,0,0), time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	In = 2


func _on_Tween_tween_completed(object, key):
	if gameover:
		get_tree().paused = true
		Variables.Game_Over()
	else:
		if begin == false:		
			if In == 1:
				fadeOut()
			if In == 2:
				$"../Enemies".SpawnWave()
				In = 0
		else:
			begin = false
