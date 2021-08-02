extends Spatial

export (NodePath) var FSMPath
onready var FSM = get_node(FSMPath)

var state_machine

func _ready():
	yield(get_tree(), "idle_frame")
	state_machine = FSM.AnimTree["parameters/MOVEMENT/playback"]
	

func Update(delta):
	pass
	
func Physics(delta):
	pass

func CheckInput():
	var left = false
	var right = false
	var up = false
	var down = false
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("UP"):
		up = true
	if Input.is_action_pressed("DOWN"):
		down = true
		
	
	if left:
		direction.x = -1
	if right:
		direction.x = 1
	if up:
		direction.y = 1
	if down:
		direction.y = -1
	
	FSM.direction = direction
	
	if direction != Vector2.ZERO:
		FSM.old_dir = FSM.direction
