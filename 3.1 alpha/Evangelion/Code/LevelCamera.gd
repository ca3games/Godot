extends Spatial

var speed = Vector3(0,0,0)
var vel = 1
onready var TweenNode = get_node("Tween")
onready var camera3D = get_node("Camera")
var finished = true

func _ready():
	pass

func _process(delta):
	if speed.x != 0 and finished:
		finished = false
		print("trans:" + str(translation))
		TweenNode.interpolate_property(camera3D, "translation", camera3D.translation, camera3D.translation + speed, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		TweenNode.start()

func Mover_Izq():
	speed.x = -vel
	
func Mover_Der():
	speed.x = vel
	
func stop():
	speed.x = 0


func _tween_completed(object, key):
	finished = true
	print ("off:" + str(translation))
