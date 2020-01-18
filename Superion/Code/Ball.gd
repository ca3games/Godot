extends RigidBody2D
var vel
var speed
var left
var up
var powerup
var timer

func _ready():
	powerup = false
	vel = 200 + (Global.level * 10)
	set_fixed_process(true)
	speed = Vector2(vel, vel)
	left = true
	up = true
	connect("body_enter", self, "bodyenter")
	timer = -99
	
func _fixed_process(delta):
	if left:
		speed.x = -vel
	else:
		speed.x = vel
	if up:
		speed.y = -vel
	else:
		speed.y = vel
	
	set_linear_velocity(speed)
	if timer > 0 :
		timer -= delta
	else:
		powerup = false
		self.get_node("Ball").set_modulate(Color(1, 1, 1))

func _bodyenter( body ):
	if body.get_name() == "Left":
		_bar()
		left = false
	if body.get_name() == "Right":
		_bar()
		left = true
	if body.get_name() == "Up":
		_bar()
		up = false
	if body.get_name() == "Down":
		get_tree().change_scene("res://Scenes/GameOver.tscn")
	if body.get_name() == "Player":
		up = !up
		if body.speed < 0:
			left = true
		else:
			left = false
	if body.is_in_group("Enemy"):
		left = !left

func _bar():
	get_tree().get_root().get_node("Node2D/SUPER")._hit()
	
func _power():
	powerup = true
	timer = 3
	self.get_node("Ball").set_modulate(Color(1, 0, 0))
