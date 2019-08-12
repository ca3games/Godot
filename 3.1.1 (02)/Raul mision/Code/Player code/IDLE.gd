extends Node

onready var root = get_parent()
onready var ani = $"../../Images/AnimationPlayer"
onready var anisprite = $"../../Images/AnimatedSprite"
onready var i = $"../../Images"

func Update(delta):
	var left = false
	var right = false
	var top = false
	var bottom = false
	
	if Input.is_action_pressed("LEFT") or Input.is_action_pressed("PAD_LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT") or Input.is_action_pressed("PAD_RIGHT"):
		right = true
	if Input.is_action_pressed("UP") or Input.is_action_pressed("PAD_UP"):
		top = true
	if Input.is_action_pressed("DOWN") or Input.is_action_pressed("PAD_DOWN"):
		bottom = true
	
	if left or right or top or bottom:
		root.ChangeState("WALKING")
	
func Physics(delta):
	if ani.current_animation != "Front":
		ani.play("Front")
	
	match(root.old_direction):
		Vector2(0, 1) : anisprite.frame = 0
		Vector2(1, 0) : 
			i.scale.x = 1
			anisprite.frame = 2
		Vector2(-1, 0) : 
			i.scale.x = -1
			anisprite.frame = 2
		Vector2(0, -1): anisprite.frame = 4
		Vector2(1, 1) : 
			i.scale.x = 1
			anisprite.frame = 1
		Vector2(-1, 1) : 
			i.scale.x = -1
			anisprite.frame = 1
		Vector2(-1, -1) :
			i.scale.x = -1
			anisprite.frame = 3
		Vector2(1, -1) : 
			i.scale.x = 1
			anisprite.frame = 3