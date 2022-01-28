extends Node2D

func UpdateHPLabel():
	$GUI.UpdateHP()

func WALKMANA():
	$GUI.WALKMANA()
	
func GetMANA():
	return $GUI.GetMANA()

func SetMANA(bomb_cost):
	$GUI.SetMANA(bomb_cost)
