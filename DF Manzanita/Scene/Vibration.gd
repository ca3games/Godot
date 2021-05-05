extends Node

var tail = 0

func BigNote():
	Input.start_joy_vibration(0, 0, 1, 0.2)

func SmallNote():
	Input.start_joy_vibration(0, 1, 0, 0.1)
	
func BigNoteSoft():
	tail = 1
	
func SmallNoteSoft():
	tail -= 0.1
	Input.start_joy_vibration(0, tail, tail, 0.1)
