extends Spatial

onready var HP = 0
export(int) var MaxHP

func HIT():
	HP += 1
	if HP > MaxHP:
		HP = MaxHP
	var red = (255 / MaxHP) * HP
	var color = Color8(255, 255 - red, 255 - red, 255)
	$"../../Mesh".material_override.albedo_color = color
	get_tree().get_root().get_node("Map/GUI").Hit()
