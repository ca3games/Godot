extends Spatial

onready var HP = 0
export(int) var MaxHP
onready var step = 255 / MaxHP

func HIT():
	HP += 1
	if HP > MaxHP:
		HP = MaxHP
	var red = GetColor()
	$"../../Mesh".material_override.albedo_color = red
	get_tree().get_root().get_node("Map/GUI").Hit()

func GuineaHIT():
	HP -= 1
	if HP < -MaxHP:
		HP = -MaxHP
	var blue = GetColor()
	$"../../Mesh".material_override.albedo_color = blue
	get_tree().get_root().get_node("Map/GUI").GuineaHit()
	

func GetColor():
	if HP > 0:
		var tmp = HP * step
		return Color8(255, 255 - tmp, 255 - tmp, 255)
	elif HP < 0:
		var tmp = abs(HP) * step
		return Color8(255 - tmp, 255 - tmp, 255, 255)
	return Color.white
