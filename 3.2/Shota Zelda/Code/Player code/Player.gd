extends KinematicBody2D

var direction = Vector2(0, 0)

func _ready():
	pass # Replace with function body.

func _process(delta):
	direction = Vector2(0, 0)
	
	var left = false
	var right = false
	var top = false
	var bottom = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("TOP"):
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
		
	match(direction):
		Vector2(-1, 0): $AnimatedSprite.frame = 6
		Vector2(1, 0): $AnimatedSprite.frame = 2
		Vector2(0, -1): $AnimatedSprite.frame = 4
		Vector2(0, 1): $AnimatedSprite.frame = 0
		Vector2(-1, -1): $AnimatedSprite.frame = 5
		Vector2(-1, 1): $AnimatedSprite.frame = 7
		Vector2(1, -1): $AnimatedSprite.frame = 3
		Vector2(1, 1): $AnimatedSprite.frame = 1
