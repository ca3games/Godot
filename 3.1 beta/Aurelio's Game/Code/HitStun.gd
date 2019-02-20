extends Node

onready var camera = get_tree().get_root().get_node("Spatial/Camera")
var shake = 0
var shake_magnitude = 0.15

func _GetHit():
	get_tree().paused = true
	$Timer.start(0.2)
	shake = shake_magnitude

func _physics_process(delta):
	if $Timer.time_left > 0:
		camera.set("h_offset", rand_range(-shake, shake))
		camera.set("v_offset", rand_range(-shake, shake))
		shake *= 0.9

func _on_Timer_timeout():
	get_tree().paused = false
	shake = 0
