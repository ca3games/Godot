extends RigidBody2D

var attack = false

func _ready():
	attack = false
	get_node("AnimationPlayer").play("IDLE")

func _input(event):
	if Input.is_action_pressed("LEFT"):
		if !attack:
			if get_node("AnimationPlayer").current_animation != "WalkBack":
				get_node("AnimationPlayer").play("WalkBack")
	elif Input.is_action_pressed("RIGHT"):
		if !attack:
			if get_node("AnimationPlayer").current_animation != "Walk":
				get_node("AnimationPlayer").play("Walk")
	else:
		if !attack:
			if get_node("AnimationPlayer").current_animation != "IDLE":
				get_node("AnimationPlayer").play("IDLE")
	if Input.is_action_pressed("PUNCH"):
		if !attack:
			attack = true
			get_node("AnimationPlayer").play("Punch")

func _stop():
	attack = false
	get_node("AnimationPlayer").play("IDLE")


func _hit(body):
	if body.is_in_group("Brutus"):
		body._hit()
