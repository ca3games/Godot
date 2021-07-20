extends Spatial

onready var current = $IDLE
onready var direction = Vector2.DOWN
export var vel : float

export (NodePath) var AnimTreePath
onready var AnimTree = get_node(AnimTreePath)

export (NodePath) var RootPath
onready var Root = get_node(RootPath)

export(float) var transpeed

func _ready():
	pass

func _process(delta):
	current.Update(delta)
	
	var target_point = Root.translation + Vector3(-direction.x, 0, -direction.y)
	var old_basis = Root.transform.basis
	old_basis.orthonormalized()
	Root.look_at(target_point, Vector3.UP)
	var target_basis = Root.transform.basis
	target_basis.orthonormalized()
	Root.transform.basis = old_basis.slerp(target_basis, delta * 10.0).orthonormalized()
	

func _physics_process(delta):
	current.Physics(delta)

func ChangeState(state):
	match (state):
		"IDLE" : current = $IDLE
		"WALK" :  current = $WALK
		"PUSH" : current = $PUSH
