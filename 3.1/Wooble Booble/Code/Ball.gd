extends KinematicBody2D

var speed = Vector2(0,0)
var vel = 250

func _ready():
	speed = Vector2(vel, -vel)

func _physics_process(delta):
	var collision = move_and_collide(speed * delta)
	if collision:
		_Bounce()
		if collision.collider.is_in_group("LEFT"):
			vel += 3
			Variables.score += 1
			speed.x = vel
		if collision.collider.is_in_group("RIGHT"):
			speed.x = -vel
			Variables.score += 1
			vel += 3
		if collision.collider.is_in_group("TOP"):
			speed.y = vel
			Variables.score += 1
			vel += 3
		if collision.collider.is_in_group("BOTTOM"):
			Variables.GameOver()
		if collision.collider.is_in_group("PADDLE"):
			speed.y = -vel
			Variables.score += 3
			vel += 3
			if $"../Paddle".speed.x != 0:
				if $"../Paddle".speed.x < 0:
					speed.x = -vel
				else:
					speed.x = vel
		Variables.SetScoreLabel()
		
func _Bounce():
	$AnimationPlayer.play("Bounce")