extends Spatial

onready var STATES = $"../"
onready var ROOT = $"../../"

func Update():
	if Input.is_action_pressed("LEFT") or Input.is_action_pressed("RIGHT") or Input.is_action_pressed("TOP") or Input.is_action_pressed("DOWN"):
		STATES.ChangeState("WALK")


func Physics(delta):
	ROOT.move_and_collide(Vector3.ZERO)
	
	if !STATES.Ani.is_playing() and STATES.Ani.current_animation != "IDLE":
		STATES.Ani.play("IDLE GUN")
