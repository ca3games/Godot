extends Spatial

var current
var speed = Vector2(0,0)
var vel = 0.01
var direction = Vector2(0,0)

func _ready():
	ChangeState("IDLE")

func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)


func ChangeState(new):
	match(new):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALK
		"SEED" : current = $SEEDING
