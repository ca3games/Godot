extends Node2D

onready var STATES = $"../"
onready var Ani = $"../../AnimationPlayer"
onready var Root = $"../../"
onready var AniRoot = $"../../AniSprite"

func Update(delta):
	
	if Input.is_action_pressed("RUN"):
		STATES.ChangeState("RUN")
		return
	
	var direction = 0
	
	if Input.is_action_pressed("LEFT"):
		direction = -1
	if Input.is_action_pressed("RIGHT"):
		direction = 1
	
	if direction == 0:
		STATES.ChangeState("IDLE")
	else:
		match(direction):
			1 : STATES.speed.x = STATES.vel
			-1 : STATES.speed.x = -STATES.vel
	

func Physics(delta):
	Root.move_and_collide(STATES.speed)
	
	if !Ani.is_playing() or Ani.current_animation != "WALK":
		if STATES.speed.x < 0 :
			AniRoot.scale = Vector2(-1, 1)
		if STATES.speed.x > 0 :
			AniRoot.scale = Vector2(1, 1)
		Ani.play("Walk")
	
