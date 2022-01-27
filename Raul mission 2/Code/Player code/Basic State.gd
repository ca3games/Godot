extends Spatial

export (NodePath) var FSMPath
onready var FSM = get_node(FSMPath)

func Update(delta):
	pass
	
func Physics(delta):
	pass

func CheckInput():
	var direction = Vector2.ZERO
	match($"../InputBuffer".buffer[0]):
		0: direction = Vector2(-1, 0)
		1: direction = Vector2(-1, 1)
		2: direction = Vector2(-1, -1)
		3: direction = Vector2(1, 1)
		4: direction = Vector2(1, -1)
		5: direction = Vector2(1, 0)
		6: direction = Vector2(0, 1)
		7: direction = Vector2(0, -1)
		8: direction = Vector2.ZERO
	FSM.direction = direction
	
	if $"../InputBuffer".idle > 20:
		FSM.direction = Vector2.ZERO
	
	if direction != Vector2.ZERO:
		FSM.old_dir = direction
