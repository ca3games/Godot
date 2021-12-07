extends "res://Code/Player/BasicState.gd"

export(float) var speed
export(Vector2) var offset

func Update(delta):
	Walk()
	FarmInput(offset)

func Physics(delta):
	var dir = Vector2(FSM.dir.x * speed * delta, FSM.dir.y * speed * delta)
	FSM.Root.move_and_collide(dir)
	SetWalkAnim()
