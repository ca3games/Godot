extends Spatial

export (NodePath) var RootPath
onready var Root = get_node(RootPath)
export(float) var vel

onready var current = $CHASE

func _ready():
	pass

func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)
