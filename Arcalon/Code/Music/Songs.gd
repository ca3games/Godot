extends Node2D

func _ready():
	PickRandomSong()

func PickRandomSong():
	var i = rand_range(1, 10)
	if i < 5 :
		$Song01.play()
		$"../".namesong = "Rise of Destiny"
	else:
		$Song02.play()
		$"../".namesong = "The Last Whisper"


func _on_Song01_finished():
	PickRandomSong()


func _on_Song02_finished():
	PickRandomSong()
