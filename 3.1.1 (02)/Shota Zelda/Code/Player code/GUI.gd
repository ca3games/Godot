extends Node2D

func _ready():
	$Timer.start(0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$Timer.start(1)
	$Stamina.value += 5
