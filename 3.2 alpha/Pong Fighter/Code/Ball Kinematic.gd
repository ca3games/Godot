extends KinematicBody

onready var speed = Vector2(5,5)

func _ready():
	randomize()
	if rand_range(-2, 2) < 0:
		speed.x = -5
	else:
		speed.x = 5

func _physics_process(delta):
	var colision = move_and_collide(Vector3(speed.x, 0, speed.y) * delta)
	
	if colision:
		var reflect = colision.remainder.bounce(colision.normal)
		speed = speed.bounce(Vector2(colision.normal.x, colision.normal.z))
		move_and_collide(reflect)
		
		if colision.collider.get_name() == "LEFT":
			$"../GUI".ChangeHP(true, -30)
		if colision.collider.get_name() == "RIGHT":
			$"../GUI".ChangeHP(false, -30)
		
		if colision.collider.get_name() == "Ship P1":
			speed.x = 5
			$"../GUI".ChangeHP(true, -7)
		if colision.collider.get_name() == "Ship P2":
			speed.x = -5
			$"../GUI".ChangeHP(false, -7)
		if colision.collider.is_in_group("Bullet"):
			if colision.collider.P1:
				speed.x = 5
			else:
				speed.x = -5
			colision.collider.Delete()

func Reverse(p1):
	if p1:
		speed.x = 10
	else:
		speed.x = -10

