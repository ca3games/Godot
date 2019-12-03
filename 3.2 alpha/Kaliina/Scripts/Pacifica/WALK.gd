extends Spatial

onready var Root = $".."
onready var Ani = $"../../AnimatedSprite3D"

func Update(delta):
	var left = false
	var right = false
	var top = false
	var bottom = false
	var direction = Vector2(0,0)
	Root.speed = Vector2(0,0)
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("TOP"):
		top = true
	if Input.is_action_pressed("BOTTOM"):
		bottom = true
		
	if left and not right:
		Root.speed.x = -Root.vel
		direction.x = -1
	
	if right and not left:
		Root.speed.x = Root.vel
		direction.x = 1
	
	if top and not bottom:
		Root.speed.y = -Root.vel
		direction.y = -1
	
	if bottom and not top:
		Root.speed.y = Root.vel
		direction.y = 1
	
	if direction != Vector2(0,0):
		Root.direction = direction
	
	if Input.is_action_pressed("SEED"):
		Root.ChangeState("SEED")
	
	if !left and !right and !top and !bottom:
		Root.ChangeState("IDLE")

func Physics(delta):
	
	if !Ani.is_playing():
		Ani.play()
		
	$"../..".move_and_collide(Vector3(Root.speed.x, 0, Root.speed.y))
	
	match(Root.direction):
		Vector2(-1, 0): 
			Ani.animation = "Side"
			Ani.flip_h = true
		Vector2(1, 0): 
			Ani.animation = "Side"
			Ani.flip_h = false
		Vector2(0, 1): 
			Ani.animation = "Front"
			Ani.flip_h = false
		Vector2(0, -1): 
			Ani.animation = "Back"
			Ani.flip_h = false
		Vector2(-1, -1): 
			Ani.animation = "Back dia"
			Ani.flip_h = true
		Vector2(1, -1): 
			Ani.animation = "Back dia"
			Ani.flip_h = false
		Vector2(-1, 1): 
			Ani.animation = "Front dia"
			Ani.flip_h = true
		Vector2(1, 1): 
			Ani.animation = "Front dia"
			Ani.flip_h = false
