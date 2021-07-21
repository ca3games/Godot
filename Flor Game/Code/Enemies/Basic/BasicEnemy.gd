extends RigidBody

export (bool) var falling
export (float) var vel
var direction = Vector2.ZERO
var d = 0.1
var last_hit = "NOBODY"

onready var GuineasManager = get_tree().get_root().get_node("Map/GUINEAS")

func HIT():
	$"SCRIPTS/COLORS".HIT()

func GuineaHIT():
	$SCRIPTS/COLORS.GuineaHIT()

func _process(delta):
	d = delta

func _integrate_forces(state):
	if not falling:
		var st = state.get_transform()
		st.origin.x += direction.x * vel * d
		st.origin.z += direction.y * vel * d
		state.set_transform(st)
