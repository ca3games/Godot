extends RigidBody2D
var speed = Vector2(0,0)
var vel = 100
var attack

func _ready():
	get_node("AnimationPlayer").play("IDLE")
	set_process_input(true)
	attack = false
	
func _input(event):
	if !attack:
		if Input.is_action_pressed("LEFT"):
			speed.x = -vel * 0.8
			if get_node("AnimationPlayer").get_current_animation() != "Walk_Back":
				get_node("AnimationPlayer").play("Walk_Back")
		elif Input.is_action_pressed("RIGHT"):
			speed.x = vel
			if get_node("AnimationPlayer").get_current_animation() != "Walk":
				get_node("AnimationPlayer").play("Walk")
		else:
			speed.x = 0
			if get_node("AnimationPlayer").get_current_animation() != "IDLE":
				get_node("AnimationPlayer").play("IDLE")
		if Input.is_action_pressed("PUNCH"):
			attack = true
			get_node("AnimationPlayer").play("Punch")
			speed.x = 0
		set_linear_velocity(speed)

func _stopunch():
	attack = false
	get_node("AnimationPlayer").play("IDLE")