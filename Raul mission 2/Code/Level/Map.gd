extends Node2D

export(NodePath) var ActionButtonsPath
onready var ActionButtons = get_node(ActionButtonsPath)

func UpdateHPLabel():
	$GUI.UpdateHP()

func WALKMANA():
	$GUI.WALKMANA()
	
func GetMANA():
	return $GUI.GetMANA()

func SetMANA(bomb_cost):
	$GUI.SetMANA(bomb_cost)
