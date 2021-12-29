extends Node2D

var Ionian = [0, 2, 4, 5, 7, 9, 11]
var Dorian = [0, 2, 3, 5, 7, 9, 10]
var Phrygian = [0, 1, 3, 5, 7, 8, 10]
var Lydian = [0, 2, 4, 6, 7, 9, 11]
var Mixolydian = [0, 2, 4, 5, 7, 9, 10]
var Aeolian = [0, 2, 4, 5, 7, 8, 10]
var Locrian = [0, 1, 3, 5, 6, 8, 10]

func GetKey(key, scale, mode):
	
	var i = GetInterval(key, scale)
	if i == 999:
		return i
	var n = 999
	
	match (mode):
		0: n = Ionian[i]
		1: n = Dorian[i]
		2: n = Phrygian[i]
		3: n = Lydian[i]
		4: n = Mixolydian[i]
		5: n = Aeolian[i]
		6: n = Locrian[i]
		
	return n

func GetInterval(key, scale):
	var n = key % 12
	n = (n + scale) % 12
	if n == 1 or n == 3 or n == 6 or n == 8 or n == 10:
		return 999
	
	match(n):
		0 : return 0
		2 : return 1
		4 : return 2
		5 : return 3
		7 : return 4
		9 : return 5
		11 : return 6
	
