extends Node

onready var R = $"../../"
onready var A = $"../../AnimationPlayer"

func _MyInput():
	
	var direction = R.direction
	var LEFT = false
	var RIGHT = false
	var DOWN = false
	var UP = false
	var none = true
	
	if Input.is_action_pressed("LEFT"):
		LEFT = true
	if Input.is_action_pressed("RIGHT"):
		RIGHT = true
	if Input.is_action_pressed("UP"):
		UP = true
	if Input.is_action_pressed("DOWN"):
		DOWN = true
	
	if LEFT or RIGHT or UP or DOWN:
		none = false
		
	if LEFT and !RIGHT:
		direction = 4
	if RIGHT and !LEFT:
		direction = 6
	if UP and !DOWN:
		direction = 8
	if DOWN and !UP:
		direction = 2
	if LEFT and UP:
		direction = 7
	if LEFT and DOWN:
		direction = 1
	if RIGHT and UP:
		direction = 9
	if RIGHT and DOWN:
		direction = 3
		
	
	R.direction = direction
	
	
	if Input.is_action_pressed("SHOOT"):
		R._ChangeStatus("shoot")
		return
	if Input.is_action_just_pressed("MELEE"):
		R._ChangeStatus("melee")
		return

	if none :
		R._ChangeStatus("idle")
	

func _Animation():
	match(R.direction):
		2:
			if A.current_animation != "Front Walking":
				A.play("Front Walking")
		6:
			if A.current_animation != "Side Right Walking":
				A.play("Side Right Walking")
		4:
			if A.current_animation != "Side Left Walking":
				A.play("Side Left Walking")
		8:
			if A.current_animation != "Back Walking":
				A.play("Back Walking")
		7:
			if A.current_animation != "Back Diagonal Left Walking":
				A.play("Back Diagonal Left Walking")
		9:
			if A.current_animation != "Back Diagonal Right Walking":
				A.play("Back Diagonal Right Walking")
		1:
			if A.current_animation != "Front Diagonal Left Walking":
				A.play("Front Diagonal Left Walking")
		3:
			if A.current_animation != "Front Diagonal Right Walking":
				A.play("Front Diagonal Right Walking")
				
func _Physics():
	match(R.direction):
		4: R.speed = Vector2(-R.vel, 0)
		2: R.speed = Vector2(0, R.vel)
		6: R.speed = Vector2(R.vel, 0)
		8: R.speed = Vector2(0, -R.vel)
		1: R.speed = Vector2(-R.vel, R.vel)
		3: R.speed = Vector2(R.vel, R.vel)
		7: R.speed = Vector2(-R.vel, -R.vel)
		9: R.speed = Vector2(R.vel, -R.vel)
	
	R.linear_velocity = Vector3(R.speed.x, 0, R.speed.y)