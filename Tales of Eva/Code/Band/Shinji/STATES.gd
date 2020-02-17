extends Node2D

onready var current = $IDLE
var speed = Vector2.ZERO
var vel = 5
var vel_run = 12
var left = false

func _process(delta):
	current.Update(delta)
	
func _physics_process(delta):
	current.Physics(delta)


func ChangeState(new):
	match(new):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALK
		"RUN" : current = $RUN
