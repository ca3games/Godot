extends RigidBody

export (bool) var falling
export (float) var vel
var direction = Vector2.ZERO
var d = 0.1

func HIT():
	$"SCRIPTS/COLORS".HIT()

func _process(delta):
	d = delta

func _integrate_forces(state):
	if not falling:
		var st = state.get_transform()
		st.origin.x += direction.x * vel * d
		st.origin.z += direction.y * vel * d
		state.set_transform(st)
