extends RigidBody2D

var speed = Vector2(0,0)
var bouncing = false
var toIdle = false
onready var TweenNode = $Tween
var vel = 50
var Idle = true
var right = true

func _ready():
	_SetSpeed()

func _process(delta):
	
	#bouncing check if there's a bounce
	#toIdle helps to avoid being called more than once
	#!Idle checks if the ball is idle
	
	if bouncing and toIdle and !Idle:
		if speed.length() < 52 :
			_finishBouncing()

func _finishBouncing():
	speed = Vector2.ZERO
	self.linear_velocity = speed
	bouncing = false
	TweenNode.interpolate_property(self, "rotation_degrees", self.rotation_degrees, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenNode.start()
	toIdle = false
	Idle = true
	_SetSpeed()

func _SetSpeed():
	if right:
		speed.x = vel
	else:
		speed.x = -vel

func _body_entered(body):
	if body.is_in_group("BALL"):
		$AnimationPlayer.play("Bounce")
		$Timer.start(3)
		Idle = false
		Variables.score += 5
		Variables.SetScoreLabel()
	
	if body.is_in_group("LEFT"):
		$AnimationPlayer.play("Bounce")
		right = true
		_SetSpeed()
	
	if body.is_in_group("RIGHT"):
		$AnimationPlayer.play("Bounce")
		right = false
		_SetSpeed()
	
	if body.is_in_group("Enemy"):
		$AnimationPlayer.play("Bounce")
		right = !right
		_SetSpeed()
		
	if body.is_in_group("HOLE") or body.is_in_group("LOWERWALL"):
		_ToDie()
		
		
func _physics_process(delta):
	if Idle:
		linear_velocity = speed


func _Timer_timeout():
	bouncing = true
	toIdle = true
	
func _ToDie():
	var number = int (Variables.GetTimeLeft() * (Variables.level + 1))
	Variables.TweenScoreLabel(number)
	Variables.SetLeftLabel()
	Variables._deadBall()
	self.queue_free()
