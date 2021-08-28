extends Node2D

export(NodePath) var FSMPath
onready var FSM = get_node(FSMPath)
var angle = 0
export(float) var magnitude

func Update(delta):
	pass

func Physics(delta):
	angle += delta
	var dir = Vector2.ZERO
	dir.x = cos(angle) * magnitude
	dir.y = FSM.Direction.y * FSM.Speed * delta
	
	FSM.Root.move_and_collide(dir)
