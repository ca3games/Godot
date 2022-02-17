extends KinematicBody2D

var level = 1
onready var startingpos = global_position
onready var avoidpos = global_position
onready var avoiding = false
var dead = false
export(bool) var BOSS

export(PackedScene) var DeadDisolve

func _ready():
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	var hp = (Variables.level + 10) * Variables.dificulty
	$FSM.HP = hp
	if BOSS:
		$FSM.HP *= 5
	$HPLifebar.max_value = $FSM.HP
	$HPLifebar.value = $FSM.HP
	SLEEP()
	$Bullet/Shoot.boss = BOSS
	
	yield(get_tree(), "idle_frame")
	
	$FSM.GetDirAngle()

func HIT(damage):
	if $FSM.HP >= 1 and !dead:
		$FSM.HP -= damage - (level / 3)
		$HPLifebar.value = $FSM.HP
		Sounds.PlayEnemyHit()
	if $FSM.HP <= 0 and !dead:
		$Bullet/Shoot.queue_free()
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

func _process(delta):
	if $HPLifebar.visible == false and $FSM.HP > 2:
		print("SUICIDE")

func AVOIDS(pos):
	avoiding = true
	var tmp = (pos - startingpos) * 0.1
	avoidpos = pos + tmp
	$AvoidStop.start(3)


func _on_AvoidStop_timeout():
	avoiding = false



func WAKEUP():
	$Bullet.start(rand_range(2, 3.5))
	$"Return to Idle".start(1)
	$Chase.start(2)

func SLEEP():
	$FSM.ChangeState("IDLE")
	$Chase.stop()
	$"Return to Idle".stop()

func _on_Visible_body_exited(body):
	if body.is_in_group("PLAYER"):
		SLEEP()


func _on_Visible_body_entered(body):
	if body.is_in_group("PLAYER"):
		WAKEUP()
