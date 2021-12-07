extends Node2D

export(NodePath) var FSMPath
onready var FSM = get_node(FSMPath)

func _ready():
	yield(get_tree(), "idle_frame")
	SetWalkAnim()

func Update(delta):
	pass

func Physics(delta):
	pass

func Walk():
	var dir = InputWalk()
	if FSM.dir.x > 0:
		FSM.SAnimTree.play("RIGHT")
	else:
		FSM.SAnimTree.play("LEFT")
	
	if dir != Vector2.ZERO:
		FSM.dir = dir
		FSM.current = $"../WALK"
	else:
		FSM.current = $"../IDLE"

func FarmInput(offset):
	if Input.is_action_just_released("FARM"):
		var s = FSM.Root.SeedsPath.instance()
		FSM.Root.SeedRoot.add_child(s)
		s.global_position = FSM.Root.global_position + offset

func InputWalk():
	var dir = Vector2.ZERO
	var left = false
	var right = false
	var up = false
	var down = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("DOWN"):
		down = true
	if Input.is_action_pressed("UP"):
		up = true
	
	if left and !right and !up and !down:
		dir.x = -1
	if right and !left and !up and !down:
		dir.x = 1
	if !left and !right and up and !down:
		dir.y = -1
	if !left and !right and !up and down:
		dir.y = 1
	
	return dir

func SetWalkAnim():
	FSM.AnimTree.set("parameters/WALK/blend_position", FSM.dir)
