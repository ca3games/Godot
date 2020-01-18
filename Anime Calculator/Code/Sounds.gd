extends Node2D

func PlayNumber(number):
	match(number):
		0 : $Zero.play()
		1 : $One.play()
		2 : $Two.play()
		3 : $Three.play()
		4 : $Four.play()
		5 : $Five.play()
		6 : $Six.play()
		7 : $Seven.play()
		8 : $Eight.play()
		9 : $Nine.play()