extends RigidBody2D

var hit
var left
var vel
var timer

func _ready():
	connect("body_enter", self, "_bodyenter")
	set_fixed_process(true)
	hit = false


func _bodyenter( body ):
	if body.is_in_group("Pool"):
		Global.score += 5
		Global._EnemyDead()
		self.queue_free()
	if body.get_name() == "Ball":
		hit = true
		timer = 0
		if body.powerup:
			self.queue_free()
	if body.is_in_group("Enemy"):
		left = !left
	if body.get_name() == "Left":
		left = false
	if body.get_name() == "Right":
		left = true

func _fixed_process(delta):
	if !hit:
		if left:
			vel = -200
		else:
			vel = 200
		set_linear_velocity(Vector2(vel, 0))
	else:
		if timer > 5:
			hit = false
		else:
			timer += delta