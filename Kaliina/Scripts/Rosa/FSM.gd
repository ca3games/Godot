extends Spatial

onready var Pacifica = $"../../Pacifica"
onready var Ani = $"../AnimationTree"

onready var current = $IDLE

func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)

func ChangeState(STATE):
	match(STATE):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALK
	print(current)
