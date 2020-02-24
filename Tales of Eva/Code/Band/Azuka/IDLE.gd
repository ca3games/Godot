extends Node2D

onready var States = $"../"
onready var Root = $"../../"
onready var Shinji = get_tree().get_root().get_node("Battle/Shinji")
onready var Ani = $"../../Ani"
onready var Player = $"../../AnimationPlayer"
var offset = 250

func Update(delta):
	
	var distance = Shinji.position.x - Root.position.x
	
	if distance > offset:
		States.speed.x = States.vel
	elif distance < -offset:
		States.speed.x = -States.vel
	else:
		States.speed.x = 0
	
func Physics(delta):
	Root.move_and_collide(States.speed)
	
	if States.speed.x < 0:
		Ani.scale = Vector2(-1, 1)
	else:
		Ani.scale = Vector2(1, 1)
	
	if States.speed.x != 0:
		if Player.current_animation != "WALK":
			Player.play("WALK")
	else:
		if Player.current_animation != "IDLE":
			Player.play("IDLE")
