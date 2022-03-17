extends Control

var id = -999
var pic = "EMPTY"

func ChangePic(p):
	pic = p

func UpdatePic():
	match(pic):
		"EMPTY" : $Tile.frame = 0
		"BASIC ENEMY" : $Tile.frame = 1
		"TOWN" : $Tile.frame = 2
		"PLAYER" : $Tile.frame = 3
		"GOLD" : $Tile.frame = 4
		"AMMO" : $Tile.frame = 5
