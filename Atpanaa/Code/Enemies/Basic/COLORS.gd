extends Spatial

export(NodePath) var RootPath
onready var Root = get_node(RootPath)
var step = 25

func _ready():
	yield(get_tree(), "idle_frame")
	step = 255 / Root.MaxHP
	
func HIT():
	Root.HP += Variables.WeaponDamage
	if Root.HP > Root.MaxHP:
		Root.HP = Root.MaxHP
	var red = GetColor()
	$"../../Mesh".material_override.albedo_color = red
	get_tree().get_root().get_node("Map/GUI").Hit()
	Root.get_node("HITSTATE").start(Variables.WeaponDamage)
	Root.attacked = true


func GuineaHIT(damage):
	Root.HP -= 1
	if Root.HP < -Root.MaxHP:
		Root.HP = -Root.MaxHP
	var blue = GetColor()
	$"../../Mesh".material_override.albedo_color = blue
	get_tree().get_root().get_node("Map/GUI").GuineaHit(damage)
	

func GetColor():
	if Root.HP > 0:
		var tmp = Root.HP * step
		return Color8(255, 255 - tmp, 255 - tmp, 255)
	elif Root.HP < 0:
		var tmp = abs(Root.HP) * step
		return Color8(255 - tmp, 255 - tmp, 255, 255)
	return Color.white
