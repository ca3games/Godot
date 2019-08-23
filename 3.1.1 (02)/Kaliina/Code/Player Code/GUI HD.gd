extends Node2D

onready var Player = $Drawing
onready var Ani_Spr = $Drawing/AnimationPlayer
var direction = Vector2(0,1)

func _process(delta):
	direction = Vector2(0,0)
	
	var left = false
	var right = false
	var top = false
	var bottom = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("UP"):
		top = true
	if Input.is_action_pressed("DOWN"):
		bottom = true
	
	if left and not right:
		direction.x = -1
	if right and not left:
		direction.x = 1
	if top and not bottom:
		direction.y = -1
	if bottom and not top:
		direction.y = 1
		

func _physics_process(delta):
	match(direction):
		Vector2(-1,0):
			if Ani_Spr.current_animation != "Side Right":
				Ani_Spr.play("Side Right")
		Vector2(1,0):
			if Ani_Spr.current_animation != "Side":
				Ani_Spr.play("Side")
		Vector2(0,1):
			if Ani_Spr.current_animation != "Front":
				Ani_Spr.play("Front")
		Vector2(0,-1):
			if Ani_Spr.current_animation != "Back":
				Ani_Spr.play("Back")
		Vector2(1,1):
			if Ani_Spr.current_animation != "Front Diagonal":
				Ani_Spr.play("Front Diagonal")
		Vector2(-1,1):
			if Ani_Spr.current_animation != "Front Diagonal Right":
				Ani_Spr.play("Front Diagonal Right")
		Vector2(-1,-1):
			if Ani_Spr.current_animation != "Back Diagonal Right":
				Ani_Spr.play("Back Diagonal Right")
		Vector2(1,-1):
			if Ani_Spr.current_animation != "Back Diagonal":
				Ani_Spr.play("Back Diagonal")