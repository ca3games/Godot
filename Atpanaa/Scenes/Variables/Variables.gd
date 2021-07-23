extends Node

export(String) var GameOver
export(String) var GameWin

export(int) var WeaponDamage
export(int) var MaxHouses

func GameOver():
	get_tree().change_scene(GameOver)
