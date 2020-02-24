extends Node2D


func _ready():
	randomize()
	music()

func music():
	if randi()%10 < 5:
		$Song1.play()
	else:
		$Song2.play()


func _on_Song1_finished():
	music()


func _on_Song2_finished():
	music()
