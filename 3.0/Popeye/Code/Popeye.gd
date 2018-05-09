extends RigidBody2D

var attack = false
var grab

func _ready():
	attack = false
	grab = false
	get_node("AnimationPlayer").play("IDLE")

func _input(event):
	if Input.is_action_pressed("LEFT"):
		if !attack:
			if get_node("AnimationPlayer").current_animation != "WalkBack":
				get_node("AnimationPlayer").play("WalkBack")
	elif Input.is_action_pressed("RIGHT"):
		if !attack:
			if get_node("AnimationPlayer").current_animation != "Walk":
				get_node("AnimationPlayer").play("Walk")
	else:
		if !attack:
			if get_node("AnimationPlayer").current_animation != "IDLE":
				get_node("AnimationPlayer").play("IDLE")
	if Input.is_action_pressed("PUNCH"):
		if !attack:
			attack = true
			get_node("AnimationPlayer").play("Punch")
	if Input.is_action_pressed("GRAB"):
		if !attack:
			attack = true
			get_node("AnimationPlayer").play("Grab")
			grab = true

func _stop():
	attack = false
	grab = false
	get_node("AnimationPlayer").play("IDLE")


func _hit(body):
	if body.is_in_group("Brutus"):
		body._hit()
	if body.is_in_group("Heart"):
		body._grab(grab)
	
func _golpe():
	attack = true
	get_node("AnimationPlayer").play("Hurt")
	var value = get_tree().get_root().get_node("Node2D/Lifebar").get_value()
	get_tree().get_root().get_node("Node2D/Lifebar").set_value(value - 5)
	if value - 5 < 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
