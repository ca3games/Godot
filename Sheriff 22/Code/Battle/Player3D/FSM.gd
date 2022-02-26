extends Node

export(NodePath) var RootPath
onready var Root = get_node(RootPath)
export(NodePath) var AnimTreePath
onready var AnimTree = get_node(AnimTreePath)

onready var direction = Vector2.DOWN
onready var old_dir = Vector2.DOWN
export (float) var vel
export(NodePath) var LeftRightAnim
onready var LeftRight = get_node(LeftRightAnim)
onready var state_machine = $"../AnimationTree".get("parameters/playback")
onready var current = $IDLE

func _process(delta):
	current.CheckInput()
	current.Update(delta)


func _physics_process(delta):
	if old_dir.x < 0:
		LeftRight.play("LEFT")
	else:
		LeftRight.play("RIGHT")
	current.Physics(delta)


func ChangeState(state):
	match (state):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALK

