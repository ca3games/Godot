extends Node2D

onready var current = $IDLE

onready var Direction = Vector2.RIGHT
export(float) var Speed
export(NodePath) var RootPath
onready var Root = get_node(RootPath)
export(NodePath) var AnimTreePath
onready var AnimTree = get_node(AnimTreePath)
export(NodePath) var SpritesPlayerPath
onready var SpritesPlayer = get_node(SpritesPlayerPath)
export(NodePath) var LeftRightPath
onready var LeftRight = get_node(LeftRightPath)

func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)

func ChangeState(state):
	match(state):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALK
