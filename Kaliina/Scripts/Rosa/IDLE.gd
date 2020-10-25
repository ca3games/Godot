extends Spatial

onready var FSM = $"../"
onready var Root = $"../../"
export (float) var walk_speed = 5

func Update(delta):
	var old_basis = Root.transform.basis
	Root.look_at(FSM.Pacifica.translation, Vector3.UP)
	var target_basis = Root.transform.basis
	var norm = old_basis.slerp(target_basis, delta * 5.0).orthonormalized()
	Root.transform.basis = norm
	
	
func Physics(delta):
	var distance = Root.translation.distance_to(FSM.Pacifica.translation)
	var walk = false
	if distance > 5:
		walk = true
	
	var walk_blend = FSM.Ani.get("parameters/WALK/blend_position")
	
	if walk:
		if walk_blend < 0.9:
			FSM.Ani.set("parameters/WALK/blend_position", walk_blend + 0.1)
		var dir = (Root.translation - FSM.Pacifica.translation).normalized()
		var speed = Vector3(-dir.x * walk_speed, 0, -dir.z * walk_speed)
		Root.move_and_collide(speed)
	else:
		if walk_blend > 0.1:
			FSM.Ani.set("parameters/WALK/blend_position", walk_blend - 0.1)

