extends RigidBody

var direction = 2
var idle = true
var speed = Vector2(0,0)
var vel = 0.5

onready var current = $STATUS/IDLE

func _input(event):
	current._MyInput()

func _process(delta):
	_input(delta)
	current._Animation()
	
func _physics_process(delta):
	current._Physics()
	
func _ChangeStatus(state):
	match(state):
		"move" : current = $STATUS/MOVE
		"idle" : current = $STATUS/IDLE
		"shoot" : current = $STATUS/SHOOT