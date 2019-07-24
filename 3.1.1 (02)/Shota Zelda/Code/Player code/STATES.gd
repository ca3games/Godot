extends Node

var direction = Vector2(0,0)
var vel = 0.5
var old_direction

var current

func _ready():
	ChangeState("IDLE")
	
func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)
	
func ChangeState(new):
	current = get_node(new)