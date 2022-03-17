extends Node2D

var playerpos = Vector2(4, 5)
var home = Vector2(4, 4)

var bandits = []

func AddBandit(x, y):
	bandits.append(Vector2(x, y))

func RemoveBandit(id):
	bandits.remove(id)

func BanditMax():
	return len(bandits)
	
func GetBanditPos(id):
	return bandits[id]
