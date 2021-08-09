extends Node

export(String) var GameOver
export(String) var GameWin

export(int) var WeaponDamage
export(int) var MaxHouses

func GameOver():
	get_tree().change_scene(GameOver)

func DeadCookie():
	$DeadCookie.start(0.2)


func _on_DeadCookie_timeout():
	get_tree().get_root().get_node("Map/MiniMap").DEADCOOKIE()
