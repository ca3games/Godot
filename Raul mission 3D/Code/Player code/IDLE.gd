extends "res://Code/Player code/BasicState.gd"


func _ready():
	pass

func Update(delta):
	var dir = .MyInput()
	if dir != Vector2.ZERO:
		FSM.ChangeState("WALK")
	.CheckButtons()

func Physics(delta):
	var i = FSM.AnimTree.get("parameters/MOVE/blend_amount")
	if i > 0:
		i -= FSM.transpeed * delta
	
	FSM.AnimTree.set("parameters/MOVE/blend_amount", i)
