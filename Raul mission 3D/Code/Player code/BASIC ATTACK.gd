extends "res://Code/Player code/BasicState.gd"

var start = false
export (String) var anim_name

func _ready():
	pass

func Update(delta):
	if not start:
		start = true
		FSM.AnimTree.set("parameters/"+anim_name+"/active", true)

func EndAnim():
	start = false
	FSM.ChangeState("IDLE")
