extends Node2D

export (NodePath) var RootPath
onready var Root = get_node(RootPath)
export(float) var vel

onready var current = $IDLE

func _ready():
	randomize()
	$"../UpdatePath".start(1)

func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)

func ChangeState(state):
	match(state):
		"IDLE" : current = $IDLE
		"CHASE" : current = $CHASE


func _on_UpdatePath_timeout():
	$"../UpdatePath".start(rand_range(2, 5))
	$"../StopChase".start(rand_range(0.3, 1))
	ChangeState("CHASE")


func _on_StopChase_timeout():
	ChangeState("IDLE")
