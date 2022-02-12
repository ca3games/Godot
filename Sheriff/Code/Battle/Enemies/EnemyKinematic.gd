extends KinematicBody2D

var type = 1
onready var startingpos = global_position
onready var avoidpos = global_position
onready var avoiding = false
var dead = false

func HIT(damage):
	$FSM.HP -= damage
	if $FSM.HP < 1 and !dead:
		dead = true
		$FSM.ChangeState("DEAD")
		$"Return to Idle".stop()
		$Chase.stop()
		$"../".GUI.EnemyDie()
		if is_instance_valid($Word):
			$Word.queue_free()

func AVOIDS(pos):
	avoiding = true
	var tmp = (pos - startingpos) * 0.1
	avoidpos = pos + tmp
	$AvoidStop.start(3)


func _on_AvoidStop_timeout():
	avoiding = false
