extends KinematicBody2D

var speed = Vector2(0,0)
var vel = 100
var flip_h = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	Checkinput()

func Checkinput():
	
	speed = Vector2(0,0)
	
	var LEFT = false
	var UP = false
	var RIGHT = false
	var DOWN = false
	
	if Input.is_action_pressed("LEFT"):
		LEFT = true
	if Input.is_action_pressed("RIGHT"):
		RIGHT = true
	if Input.is_action_pressed("UP"):
		UP = true
	if Input.is_action_pressed("DOWN"):
		DOWN = true
		
	if UP and !DOWN:
		speed = Vector2(0, -vel)
	if !UP and DOWN:
		speed = Vector2(0, vel)
	if LEFT and !RIGHT:
		speed = Vector2(-vel, 0)
		if !flip_h:
			$AnimationPlayer.play("IDLE")
			scale.x = -1
			flip_h = true
		if UP:
			speed = Vector2(-vel, -vel)
		if DOWN:
			speed = Vector2(-vel, vel)
	if RIGHT and !LEFT:
		speed = Vector2(vel, 0)
		if flip_h:
			$AnimationPlayer.play("IDLE")
			scale.x = -1
			flip_h = false
		if UP:
			speed = Vector2(vel, -vel)
		if DOWN:
			speed = Vector2(vel, vel)


func _physics_process(delta):
	move_and_slide(speed)