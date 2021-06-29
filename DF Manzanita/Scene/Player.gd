extends Node

export (float) var speed
var speed_x = 0

onready var current = $IDLE

func _ready():
	pass

func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)

func ChangeState(state):
	match(state):
		"IDLE" :  current = $IDLE
		"WALK" :  current = $WALK


func flip(direction):
	speed_x = direction
	
	if direction == -1:
		$"../Sprite".flip_h = true
	if direction == 1:
		$"../Sprite".flip_h = false
