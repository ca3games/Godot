extends CanvasLayer

func _on_Time_Left_timeout():
	$Time_Bar.value -= 1
	
	if $Time_Bar.value < 1:
		$"../".Reload()
		$Time_Bar.value = 60
	
	$Time_Label.text = str($Time_Bar.value)
