extends Spatial

export (NodePath) var RootPath
onready var Root = get_node(RootPath)

export (float) var vel
onready var current = $Idle

export (String) var sLEFT
export (String) var sRIGHT
export (String) var sUP
export (String) var sDOWN

onready var direction = Vector2.ZERO

func _process(delta):
	current.Update(delta)
	
func _physics_process(delta):
	current.Physics(delta)

func ChangeState(STATE):
	match (STATE):
		"IDLE" : current = $Idle
		"WALK" : current = $Walk
