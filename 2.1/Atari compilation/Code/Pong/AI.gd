extends RigidBody2D

var x
var vel = 150
var speed = Vector2(0,0)
onready var TweenNode = get_node("Tween")

func _ready():
	x = get_global_pos().x
	set_fixed_process(true)

func _fixed_process(delta):
	set_global_pos(Vector2(x, get_global_pos().y))
	
	var y = get_node("/root/Node/Ball").get_global_pos().y
	if y > get_global_pos().y:
		speed.y = vel
	else:
		speed.y = -vel
	set_linear_velocity(speed)	
	
func bounce():
	TweenNode.interpolate_property(get_node("paddle"), "transform/scale", Vector2(0.8, 1.4), Vector2(1,1), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	TweenNode.start()
