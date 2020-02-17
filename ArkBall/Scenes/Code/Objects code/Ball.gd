extends KinematicBody2D

onready var Ani = $AnimationPlayer

var speed = Vector2(0,0)
var vel = 300

func _ready():
	speed = Vector2(vel, -vel)

func _physics_process(delta):
	var collision = move_and_slide(speed)
	

func body_entered(body):
	get_tree().get_root().get_node("Root").Bounce(2)
	Variables.AddScore(1)
	
	if body.is_in_group("BOTTOM"):
		get_tree().get_root().get_node("Root").Hit(20)
		speed.y = -vel
	
	if body.is_in_group("LEFT"):
		speed.x = vel
	
	if body.is_in_group("RIGHT"):
		speed.x = -vel
		
	if body.is_in_group("TOP"):
		speed.y = vel
	
	if body.is_in_group("PADDLE"):
		speed.y = -speed.y
		if position.x < body.position.x:
			speed.x = -vel
		if position.x > body.position.x:
			speed.x = vel
		
	Ani.play("Bounce")

func Switch():
	if speed.y < 0:
		speed.x *= -1
	else:
		speed.y = -vel
