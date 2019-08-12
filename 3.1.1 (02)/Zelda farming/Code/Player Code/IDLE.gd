extends Node

onready var root = $"../.."
onready var states = $"../"
onready var Player = $"../../Player"
onready var Ani = $"../../Player/AnimationPlayer"
onready var Ani_Spr = $"../../Player/AnimatedSprite"

func Update(delta):
	
	root.direction = Vector2(0,0)
	
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
		root.direction.x = -1
	if right and not left:
		root.direction.x = 1
	if top and not bottom:
		root.direction.y = -1
	if bottom and not top:
		root.direction.y = 1
	
	if root.direction != Vector2(0,0):
		root.old_direction = root.direction
	
func Physics(delta):
	match(root.old_direction):
		Vector2(-1,0):
			Player.scale.x = -1
			Ani_Spr.animation = "IDLE"
			Ani_Spr.frame = 4
		Vector2(1,0):
			Player.scale.x = 1
			Ani_Spr.animation = "IDLE"
			Ani_Spr.frame = 4
		Vector2(0,1):
			Player.scale.x = 1
			Ani_Spr.animation = "IDLE"
			Ani_Spr.frame = 3
		Vector2(0,-1):
			Player.scale.x = 1
			Ani_Spr.animation = "IDLE"
			Ani_Spr.frame = 1
		Vector2(1,1):
			Player.scale.x = 1
			Ani_Spr.animation = "IDLE"
			Ani_Spr.frame = 2
		Vector2(-1,1):
			Player.scale.x = -1
			Ani_Spr.animation = "IDLE"
			Ani_Spr.frame = 2
		Vector2(-1,-1):
			Player.scale.x = -1
			Ani_Spr.animation = "IDLE"
			Ani_Spr.frame = 0
		Vector2(1,-1):
			Player.scale.x = 1
			Ani_Spr.animation = "IDLE"
			Ani_Spr.frame = 0
