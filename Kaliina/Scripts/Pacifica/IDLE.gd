extends Spatial

onready var Root = $".."
onready var Ani = $"../../AnimatedSprite3D"

func Update(delta):
	if Input.is_action_pressed("LEFT") or Input.is_action_pressed("RIGHT") or Input.is_action_pressed("TOP") or Input.is_action_pressed("BOTTOM"):
		Root.ChangeState("WALK")
		
	if Input.is_action_pressed("SEED"):
		Root.ChangeState("SEED")
		
func Physics(delta):
	Ani.stop()
	
	match(Root.direction):
		Vector2(-1, 0): 
			Ani.frame = 0
			Ani.animation = "Side"
			Ani.flip_h = true
		Vector2(1, 0): 
			Ani.frame = 0
			Ani.animation = "Side"
			Ani.flip_h = false
		Vector2(0, 1): 
			Ani.frame = 0
			Ani.animation = "Front"
			Ani.flip_h = false
		Vector2(0, -1): 
			Ani.frame = 0
			Ani.animation = "Back"
			Ani.flip_h = false
		Vector2(-1, -1): 
			Ani.frame = 0
			Ani.animation = "Back dia"
			Ani.flip_h = true
		Vector2(1, -1): 
			Ani.frame = 0
			Ani.animation = "Back dia"
			Ani.flip_h = false
		Vector2(-1, 1): 
			Ani.frame = 0
			Ani.animation = "Front dia"
			Ani.flip_h = true
		Vector2(1, 1): 
			Ani.frame = 0
			Ani.animation = "Front dia"
			Ani.flip_h = false
