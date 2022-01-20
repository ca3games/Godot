extends Node

export(NodePath) var FSMPath
onready var FSM = get_node(FSMPath)


func Update(delta):
	pass

func Physics(delta):
	pass

func MyInput():
	var dir = Vector2.ZERO
	var left = false
	var right = false
	var up = false
	var down = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("UP"):
		up = true
	if Input.is_action_pressed("DOWN"):
		down = true
	
	if left:
		dir.x = -1
	if right:
		dir.x = 1
	if up:
		dir.y = -1
	if down:
		dir.y = 1
	
	return dir

func CheckButtons():
	if Input.is_action_pressed("PUNCH"):
		FSM.ChangeState("PUNCH")
	
