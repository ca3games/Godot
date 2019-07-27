extends Node

var offset

func _ready():
	set_process(false)

func _process(delta):
	var x = rand_range(-offset, offset)
	var y = rand_range(-offset, offset)
	$Camera2D.offset = Vector2(x, y)

func Stop():
	set_process(false)

func Start(new):
	offset = new
	$Timer.start(0.2)
	get_tree().paused = true
	set_process(true)
	yield($Timer, "timeout")
	set_process(false)
	get_tree().paused = false