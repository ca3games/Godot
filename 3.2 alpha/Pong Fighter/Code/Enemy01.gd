extends KinematicBody

onready var follow = $".."

func _process(delta):
	follow.set_offset(follow.get_offset() + 5 * delta)
	
func Hit():
	$AnimationPlayer.play("Hit")
