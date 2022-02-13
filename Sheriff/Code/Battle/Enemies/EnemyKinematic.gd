extends KinematicBody2D

var level = 1
onready var startingpos = global_position
onready var avoidpos = global_position
onready var avoiding = false
var dead = false

func _ready():
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	var hp = Variables.level + 10
	$FSM.HP = hp
	$HPLifebar.max_value = $FSM.HP
	$HPLifebar.value = $FSM.HP
	
	$Bullet.start(rand_range(3, 8))

func HIT(damage):
	$FSM.HP -= damage - (level / 3)
	$HPLifebar.value = $FSM.HP
	Sounds.PlayEnemyHit()
	if $FSM.HP < 1 and !dead:
		$Bullet.stop()
		$HPLifebar.hide()
		Sounds.PlayGrunt(level / 2)
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
