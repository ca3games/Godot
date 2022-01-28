extends Node2D

enum Test {Attack, heal, test}

func GetName(test):
	match(test):
		0 : return "ATTACK"
		1 : return "HEAL"
		2 : return "TEST"
