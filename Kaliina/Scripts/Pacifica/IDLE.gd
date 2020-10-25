extends Spatial

onready var Ani
onready var Root = $"../../"
onready var FSM = $"../"

func _ready():
	yield(get_tree(), "idle_frame")
	Ani = Root.get_node("Pacifica/AnimationPlayer")

func Update(delta):
	var left = false
	var right = false
	var up = false
	var down = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("DOWN"):
		down = true
	if Input.is_action_pressed("UP"):
		up = true
	
	if left or right or down or up:
		FSM.ChangeState("WALK")

func Physics(delta):
	if Ani == null:
		return

	var walk_blend = FSM.Ani.get("parameters/WALK/blend_position")
	
	if walk_blend != 0:
		if walk_blend > 0.1:
			FSM.Ani.set("parameters/WALK/blend_position", walk_blend - 0.1)
