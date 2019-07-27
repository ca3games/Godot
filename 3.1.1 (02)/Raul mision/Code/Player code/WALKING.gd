extends Node

onready var root = get_parent()
onready var ani = $"../../Images/AnimationPlayer"

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
	if Input.is_action_pressed("TOP"):
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
	
	if root.direction != Vector2.ZERO:
		root.old_direction = root.direction
		
	if not left and not right and not top and not bottom:
		root.ChangeState("IDLE")
	
func Physics(delta):
	if root.direction.y == 1 and root.direction.x != 0:
		if ani.current_animation != "FrontDiagonal Walk":
			ani.play("FrontDiagonal Walk")
	if root.direction.y == -1 and root.direction.x != 0:
		if ani.current_animation != "Back Diagonal Walk":
			ani.play("Back Diagonal Walk")
	if root.direction.y == 0 and root.direction.x != 0:
		if ani.current_animation != "Side Walk":
			ani.play("Side Walk")
	if root.direction.y == 1 and root.direction.x == 0:
		if ani.current_animation != "Front Walk":
			ani.play("Front Walk")
	if root.direction.y == -1 and root.direction.x == 0:
		if ani.current_animation != "Back Walk":
			ani.play("Back Walk")
	
	$"../../".move_and_collide(root.direction * root.vel * 1.2)
	if root.direction.x < 0:
		$"../../Images".scale.x = -1
	else:
		$"../../Images".scale.x = 1