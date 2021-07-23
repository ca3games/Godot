extends RigidBody

export (bool) var falling
export (float) var vel
var last_hit = "NOBODY"
export(int) var HP
export(int) var MaxHP
export (bool) var attacked
export(int) var fruitdamage

onready var GuineasManager = get_tree().get_root().get_node("Map/GUINEAS")

func HIT():
	$"SCRIPTS/COLORS".HIT()

func GuineaHIT(damage):
	$SCRIPTS/COLORS.GuineaHIT(damage)
