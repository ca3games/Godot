extends "res://Code/Player code/BasicState.gd"


func _ready():
	pass


func Update(delta):
	var dir = .MyInput()
	if dir == Vector2.ZERO:
		FSM.ChangeState("IDLE")
	else:
		FSM.dir = dir
	.CheckButtons()

func Physics(delta):
	
	var dir = FSM.dir * FSM.vel * delta
	
	FSM.Root.move_and_collide(Vector3(dir.x, 0, dir.y), false)
	
	var i = FSM.AnimTree.get("parameters/MOVE/blend_amount")
	if i < 1:
		i += FSM.transpeed * delta
		
	FSM.AnimTree.set("parameters/MOVE/blend_amount", i)
