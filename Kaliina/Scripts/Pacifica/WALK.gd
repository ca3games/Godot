extends Spatial


onready var Root = $"../../"
onready var FSM = $"../"


func _ready():
	yield(get_tree(), "idle_frame")


func Update(delta):
	var current = Vector2.ZERO
	var left = false
	var right = false
	var up = false
	var down = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
		current.x = 1
	if Input.is_action_pressed("RIGHT"):
		right = true
		current.x = -1
	if Input.is_action_pressed("DOWN"):
		down = true
		current.y = 1
	if Input.is_action_pressed("UP"):
		up = true
		current.y = -1
	
	if current != Vector2.ZERO:
		FSM.direction = current
	else:
		FSM.old_direction = FSM.direction
		FSM.ChangeState("IDLE")

func Physics(delta):
	
	var walk_blend = FSM.Ani.get("parameters/WALK/blend_position")
	
	if walk_blend < 0.9:
		FSM.Ani.set("parameters/WALK/blend_position", walk_blend + 0.1)

	
	var dir = Vector3(-FSM.direction.x * FSM.speed, 0, FSM.direction.y * FSM.speed)
	
	Root.move_and_collide(dir)
	
