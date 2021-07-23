extends Spatial

onready var current = $CHASE
export(NodePath) var RootPath
onready var Root = get_node(RootPath)
export(float) var ChaseVel
export(float) var PushForce
export(float) var PushY

func _ready():
	pass

func _process(delta):
	current.Update(delta)
	
func _physics_process(delta):
	current.Physics(delta)


func ChangeState(state):
	match(state):
		"CHASE" : current = $CHASE
		"IDLE" : current = $IDLE
