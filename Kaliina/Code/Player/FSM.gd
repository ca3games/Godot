extends Node2D

export(NodePath) var RootPath
onready var Root = get_node(RootPath)
export(NodePath) var AnimTreePath
onready var AnimTree = get_node(AnimTreePath)
export(NodePath) var SpriteParentPath
onready var SpriteParent = get_node(SpriteParentPath)
onready var dir = Vector2.DOWN
onready var old_dir = Vector2.DOWN
onready var current = $IDLE
onready var left = false

func _ready():
	pass

func _process(delta):
	current.Update(delta)
	
func _physics_process(delta):
	current.Physics(delta)
