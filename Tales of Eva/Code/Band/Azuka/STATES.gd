extends Node2D

var current
var speed = Vector2.ZERO
var vel = 4

func _ready():
	ChangeState("IDLE")

func _process(delta):
	current.Update(delta)
	
func _physics_process(delta):
	current.Physics(delta)
	
func ChangeState(new):
	match(new):
		"IDLE" : current = $IDLE
