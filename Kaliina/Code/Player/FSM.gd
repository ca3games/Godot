extends Node2D

export(NodePath) var RootPath
onready var Root = get_node(RootPath)
export(NodePath) var AnimTreePath
onready var AnimTree = get_node(AnimTreePath)
export(NodePath) var SAnimTreePath
onready var SAnimTree = get_node(SAnimTreePath)
onready var dir = Vector2.DOWN
onready var old_dir = Vector2.DOWN
onready var current = $IDLE

func _ready():
	pass

func _process(delta):
	current.Update(delta)
	
func _physics_process(delta):
	current.Physics(delta)
