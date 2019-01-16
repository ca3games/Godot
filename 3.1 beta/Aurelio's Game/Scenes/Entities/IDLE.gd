extends Node

onready var R = $"../../"
onready var A = $"../../AnimationPlayer"

func _MyInput():
	if Input.is_action_pressed("SHOOT"):
		R._ChangeStatus("shoot")
	
	if Input.is_action_pressed("LEFT") or Input.is_action_pressed("RIGHT") or Input.is_action_pressed("UP") or Input.is_action_pressed("DOWN"):
		R._ChangeStatus("move")

func _Animation():
	match(R.direction):
		2:
			if A.current_animation != "Front":
				A.play("Front")
		6:
			if A.current_animation != "Side Right":
				A.play("Side Right")
		4:
			if A.current_animation != "Side Left":
				A.play("Side Left")
		8:
			if A.current_animation != "Back":
				A.play("Back")
		7:
			if A.current_animation != "Back Diagonal Left":
				A.play("Back Diagonal Left")
		9:
			if A.current_animation != "Back Diagonal Right":
				A.play("Back Diagonal Right")
		1:
			if A.current_animation != "Front Diagonal Left":
				A.play("Front Diagonal Left")
		3:
			if A.current_animation != "Front Diagonal Right":
				A.play("Front Diagonal Right")

func _Physics():
	R.linear_velocity = Vector3(0,0,0)