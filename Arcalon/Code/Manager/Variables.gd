extends Node

onready var Level = 1
export(String) var BattleWin
export(String) var BattleLost

onready var HP = 100

func WinLevel():
	Level += 1
	get_tree().change_scene(BattleWin)
	
func GameOver():
	Level = 1
	HP = 100
	get_tree().change_scene(BattleLost)
