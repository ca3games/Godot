extends RigidBody2D

var vel = 200
var speed = Vector2(vel, vel)
onready var TweenNode = get_node("Tween")
onready var Particle = preload("res://Scenes/Pong/bounce particle.tscn")

func _ready():
	set_linear_velocity(speed)
	set_fixed_process(true)
	
func _fixed_process(delta):
	set_linear_velocity(speed)

func _body_enter( body ):
	vel += 20
	if body.is_in_group("LEFT"):
		vel = 100
		set_global_pos(get_node("/root/Node/Center_X").get_global_pos())
		Global.P2 += 1
		get_node("/root/Node/P2").set_text(str(Global.P2))
	if body.is_in_group("RIGHT"):
		vel = 100
		Global.P1 += 1
		get_node("/root/Node/P1").set_text(str(Global.P1))
		set_global_pos(get_node("/root/Node/Center_X").get_global_pos())
	if body.is_in_group("TOP"):
		speed.y = vel
	if body.is_in_group("BOTTOM"):
		speed.y = -vel
	if body.is_in_group("PLAYER"):
		speed.x = vel
		body.set_linear_velocity(Vector2(0,0))
	if body.is_in_group("AI"):
		speed.x = -vel
		body.set_linear_velocity(Vector2(0,0))
		body.bounce()
	TweenNode.interpolate_property(get_node("ball"), "transform/scale", Vector2(2,2), Vector2(1,1), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	TweenNode.interpolate_property(get_node("ball"), "modulate", Color(1,1,1,1), Color(1, 0.7, 0, 1), 1, Tween.TRANS_SINE, Tween.EASE_OUT)
	TweenNode.interpolate_property(get_node("ball/ball blur"), "modulate", Color(1,1,1,1), Color(1, 0.7, 0, 1), 1, Tween.TRANS_SINE, Tween.EASE_OUT)
	TweenNode.start()
	
	var p = Particle.instance()
	p.set_global_pos(self.get_global_pos())
	get_node("/root/Node/Particles").add_child(p)