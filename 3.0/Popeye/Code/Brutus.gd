extends RigidBody2D

var attack = false

enum STATE { idle, walk, walkback, punch, hurt}
var status
var speed = Vector2(0,0)
var vel = 50
var timer

func _ready():
	get_node("AnimationPlayer").play("IDLE")
	status = STATE.idle
	timer = -99
	
func _process(delta):
	if timer < 0:
		_AI(_getdistance())
	else:
		timer -= delta
	
	if !attack:
		if status == STATE.hurt:
			return
		
		match status:
			STATE.idle: _idle()
			STATE.walk: _walk()
			STATE.walkback: _walkback()
			STATE.punch: _punch()
		
	
func _AI(distance):
	var ai = randi()%10+1
	if distance < 50:
		if ai < 5:
			status = STATE.punch
			timer = 1
		else:
			status = STATE.walkback
			timer = 1
		return
	
	if distance > 50:
		if ai < 5:
			status = STATE.idle
			timer = 1.2
		else:
			if ai > 8:
				status = STATE.walkback
				timer = 1
			else:
				status = STATE.walk
				timer = 1.5
	else:
		if ai < 5:
			status = STATE.idle
			timer = 0.7
		else:
			status = STATE.walkback
			timer = 0.5
			
func _getdistance():
	var popeye = get_tree().get_root().get_node("Node2D/Popeye").position.x
	return position.x - popeye

func _idle():
	if get_node("AnimationPlayer").current_animation != "IDLE":
		get_node("AnimationPlayer").play("IDLE")

func _walk():
	if get_node("AnimationPlayer").current_animation != "Walk":
		get_node("AnimationPlayer").play("Walk")
	
func _walkback():
	if get_node("AnimationPlayer").current_animation != "WalkBack":
		get_node("AnimationPlayer").play("WalkBack")
		
		
func _punch():
	if get_node("AnimationPlayer").current_animation != "Punch":
		get_node("AnimationPlayer").play("Punch")

func _stop():
	attack = false
	status = STATE.idle
	get_node("AnimationPlayer").play("IDLE")
	timer = -99
	
func _hit():
	attack = true
	get_node("AnimationPlayer").play("Hurt")

func _Area2D(body):
	if body.is_in_group("Popeye"):
		body._golpe()
