extends Spatial

onready var Root = $"../../"
onready var TweenFall = $"../../Tween"

var standing = false

func _process(delta):
	
	if Root.attacked:
		return
	
	var speed = Root.linear_velocity.x + Root.linear_velocity.y + Root.linear_velocity.z
	if abs(speed) < 0.01 and !standing and Root.falling:
		standing = true
		TweenFall.interpolate_property(Root, "rotation_degrees", Root.rotation_degrees, Vector3.ZERO, 2, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
		TweenFall.start()


func _on_Tween_tween_completed(object, key):
	standing = false
	Root.falling = false

func _on_HITSTATE_timeout():
	Root.attacked = false
	print("ATTACKED ENDED")
