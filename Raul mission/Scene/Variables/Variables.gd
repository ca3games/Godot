extends Node

export(String) var WinningLevel
export(String) var LosingLevel
export(int) var current_bomb
export (int) var HP

func _ready():
	SetHP(0)

func GameWin():
	get_tree().change_scene(WinningLevel)

func GameOver():
	get_tree().change_scene(LosingLevel)

func SetHP(damage):
	get_tree().get_root().get_node("Map").UpdateHPLabel()
	HP += damage
	if HP < 1:
		GameOver()

func GetMana():
	return get_tree().get_root().get_node("Map").GetMANA()

func SetManaSpawn():
	get_tree().get_root().get_node("Map").SetMANA($Enemies.bomb_cost[current_bomb])
