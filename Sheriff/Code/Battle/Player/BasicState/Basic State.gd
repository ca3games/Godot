extends Node2D

export (NodePath) var FSMPath
onready var FSM = get_node(FSMPath)

func Update(delta):
	pass
	
func Physics(delta):
	pass

func CheckInput():
	var direction = Vector2.ZERO
	var left = false
	var right = false
	var up = false
	var down = false
	
	if Input.is_action_pressed("LEFT"):
		direction.x = -1
	if Input.is_action_pressed("RIGHT"):
		direction.x = 1
	if Input.is_action_pressed("UP"):
		direction.y = 1
	if Input.is_action_pressed("DOWN"):
		direction.y = -1
	
	
	FSM.direction = direction
	if direction != Vector2.ZERO:
		FSM.old_dir = direction
