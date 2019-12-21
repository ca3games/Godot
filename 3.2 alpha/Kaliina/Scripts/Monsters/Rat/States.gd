extends Spatial

onready var Root = $"../"
onready var Pacifica
var current
var Speed
var vel = 0.2

func _ready():
	yield(get_tree(), "idle_frame") 
	Pacifica = get_tree().get_root().get_node("Root/Pacifica")
	current = $WALK

func _process(delta):
	if current != null:
		current.Update(delta)

func _physics_process(delta):
	if current != null:
		current.Physics(delta)


func ChangeStatus(status):
	match(status):
		"IDLE" : current = $IDLE
		"CHASE" : current = $WALK

func ChangeStatusRandom():
	var new = rand_range(0,4)
	if new < 2:
		ChangeStatus("IDLE")
	else:
		ChangeStatus("CHASE")
