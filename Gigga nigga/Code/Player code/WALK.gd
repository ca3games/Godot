extends Spatial

onready var STATES = $"../"
onready var ROOT = $"../../"

func Update():
	var direction = Vector3.ZERO
	STATES.facing = Vector2.ZERO
	
	if Input.is_action_pressed("LEFT"):
		STATES.facing.x = -1
		direction += (ROOT.transform.basis.x * STATES.vel)
	if Input.is_action_pressed("RIGHT"):
		STATES.facing.x = 1
		direction += (-ROOT.transform.basis.x * STATES.vel)
	if Input.is_action_pressed("TOP"):
		STATES.facing.y = 1
		direction += (ROOT.transform.basis.z * STATES.vel)
	if Input.is_action_pressed("DOWN"):
		STATES.facing.y = -1
		direction += (-ROOT.transform.basis.z * STATES.vel)
	
	STATES.speed = direction
	
	if direction == Vector3.ZERO:
		STATES.ChangeState("IDLE")
		
func Physics(delta):
	ROOT.move_and_slide(STATES.speed, Vector3.UP)
	
	if STATES.facing.y >= 0:
		if STATES.Ani.current_animation != "WALKING FORWARD":
			STATES.Ani.play("WALKING FORWARD")
	else:
		if STATES.Ani.current_animation != "WALKING BACKWARDS":
			STATES.Ani.play("WALKING BACKWARDS")
