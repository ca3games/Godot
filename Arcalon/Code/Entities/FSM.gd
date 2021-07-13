extends Node2D

export(NodePath) var StartingNode
onready var current = get_node(StartingNode)

export (NodePath) var RootPath
onready var Root = get_node(RootPath)

export(float) var speed
export(Vector2) var Direction

func _process(delta):
	if current != null:
		current.Update(delta)

func _physics_process(delta):
	if current != null:
		current.Physics(delta)

func ChangeState(STATE):
	match (STATE):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALKING
