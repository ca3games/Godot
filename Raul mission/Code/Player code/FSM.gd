extends Spatial

onready var current = $IDLE

export(NodePath) var RootPath
onready var Root = get_node(RootPath)
export(NodePath) var AnimTreePath
onready var AnimTree = get_node(AnimTreePath)

onready var direction = Vector2.DOWN
onready var old_dir = Vector2.DOWN
export (float) var vel
export(NodePath) var LeftRightAnim
onready var LeftRight = get_node(LeftRightAnim)

func _ready():
	pass

func _process(delta):
	current.CheckInput()
	current.Update(delta)

func _physics_process(delta):
	if old_dir.x < 0:
		LeftRight.play("Right")
	else:
		LeftRight.play("LEFT")
	current.Physics(delta)

func ChangeState(state):
	match (state):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALK
		"BOMB" : current = $BOMB
