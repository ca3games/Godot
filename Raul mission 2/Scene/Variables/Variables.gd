extends Node

export(String) var WinningLevel
export(String) var LosingLevel
export(int) var current_bomb
export (int) var HP

onready var Map

func _ready():
	yield(get_tree(),"idle_frame")
	Map = get_tree().get_root().get_node("BattleWrap").find_node("GUI")
	SetHP(0)

func GameWin():
	get_tree().change_scene(WinningLevel)

func GameOver():
	get_tree().change_scene(LosingLevel)

func SetHP(damage):
	Map.UpdateHP()
	HP += damage
	if HP < 1:
		GameOver()

func GetMana():
	return Map.GetMANA()

func SetManaSpawn():
	Map.SetMANA($Enemies.bomb_cost[current_bomb])
