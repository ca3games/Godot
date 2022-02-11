extends KinematicBody2D

var type = 1
onready var startingpos = global_position

func HIT(damage):
	$FSM.HP -= damage
	if $FSM.HP < 1:
		$FSM.ChangeState("DEAD")
		$"Return to Idle".stop()
		$Chase.stop()
		if is_instance_valid($Word):
			$Word.queue_free()
