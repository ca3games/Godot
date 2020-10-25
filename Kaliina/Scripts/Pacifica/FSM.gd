extends Spatial

onready var current = $"IDLE"
onready var direction = Vector2.DOWN
onready var old_direction = Vector2.DOWN
onready var Root = $"../"
export(float) var speed = 5
onready var Ani = $"../AnimationTree"


func _process(delta):
	current.Update(delta)
	
func _physics_process(delta):
	current.Physics(delta)
	
	var target_point = Root.translation + Vector3(direction.x, 0, -direction.y)
	var old_basis = Root.transform.basis
	Root.look_at(target_point, Vector3.UP)
	var target_basis = Root.transform.basis
	Root.transform.basis = old_basis.slerp(target_basis, delta * 10.0)
	
	
func ChangeState(STATE):
	match (STATE):
		"IDLE" : current = $IDLE
		"WALK" :  current = $WALK

func Rotate_Angle():
	var angle
	match (direction):
		Vector2(0, 1): angle = Vector3.ZERO
		Vector2(-1, 0): angle = Vector3(0, 90, 0)
		Vector2(1, 0): angle = Vector3(0, -90, 0)
		Vector2(0, -1): angle = Vector3(0, 180, 0)
		Vector2(1, 1): angle = Vector3(0, -45, 0)
		Vector2(-1, 1): angle = Vector3(0, 45, 0)
		Vector2(-1, -1): angle = Vector3(0, 145, 0)
		Vector2(1, -1): angle = Vector3(0, -145, 0)
	
	return angle
