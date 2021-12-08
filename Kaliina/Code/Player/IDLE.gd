extends "res://Code/Player/BasicState.gd"

export(Vector2) var offset

onready var start = false

func _ready():
	yield(get_tree(), "idle_frame")
	ChangeAnim()

func Update(delta):
	Walk()
	FarmInput(offset)
	if !start:
		start = true
		ChangeAnim()


func ChangeAnim():
	FSM.AnimTree.set("parameters/BlendWalk/blend_amount", 1)
	FSM.AnimTree.set("parameters/IDLE/blend_position", FSM.old_dir)
	
