extends Node2D

onready var STATES = $"../"
onready var Ani = $"../../AnimationPlayer"
onready var Root = $"../../"

func Update(delta):
	
	STATES.speed = Vector2.ZERO
	
	if Input.is_action_pressed("LEFT") or Input.is_action_pressed("RIGHT"):
		STATES.ChangeState("WALK")

func Physics(delta):
	Root.move_and_collide(STATES.speed)
	if !Ani.is_playing() or Ani.current_animation != "IDLE":
		Ani.play("IDLE")
	
