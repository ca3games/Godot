extends Camera2D

var speed = 100
var vel = Vector2(0,0)
var finished = true
onready var TweenNode = get_node("CameraTween")
onready var Level = get_node("/root/Node/PBackground/CViewport/Viewport/Spatial")


func _process(delta):
	if vel.x != 0 and finished:
		finished = false
		TweenNode.interpolate_property(self, "position", position, position + vel, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		TweenNode.start()


func _Right_entered(body):
	if body.is_in_group("Azuka"):
		vel.x = speed
		Level.Mover_Der()

func _Right_exited(body):
	if body.is_in_group("Azuka"):
		vel.x = 0
		Level.stop()

func _tween_completed(object, key):
	finished = true


func _Lef_entered(body):
	if body.is_in_group("Azuka"):
		vel.x = -speed
		Level.Mover_Izq()

func _Left_exited(body):
	if body.is_in_group("Azuka"):
		vel.x = 0
		Level.stop()
