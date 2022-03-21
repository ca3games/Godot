extends KinematicBody2D

enum basiccolor {mex1, mex2, mex3, mex4, white1, white2, white3, black1, black2, black3}

export(basiccolor) var skin
onready var level = 0
export(int) var HP = 10
export(int) var speed = 10
export(int) var idletimer = 5
export(int) var chasetimer = 8
export(int) var damage = 10
onready var startingpos
onready var avoidpos = global_position
onready var avoiding = false
var dead = false
export(bool) var BOSS
export(bool) var DropBasicAmmo

export(PackedScene) var DeadDisolve
export(PackedScene) var Gun01

func _ready():
	randomize()
	startingpos = global_position
	var x = sign(rand_range(-3, 2))
	var y = sign(rand_range(-3, 2))
	var dir = Vector2(x, y) * 20
	startingpos += dir
	
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	$HPLifebar.max_value = HP
	$HPLifebar.value = HP
	SLEEP()
	$Bullet/Shoot.boss = BOSS
	
	yield(get_tree(), "idle_frame")
	
	$FSM.GetDirAngle()

func HIT(damage):
	Variables.AddScore(damage)
	$"../".GUI.UpdateScore()
	HP -= damage
	$HPLifebar.value = HP
	$"/root/Battle/Sounds".PlayEnemyHit()

func _process(delta):
	if HP <= 0 and !dead:
		$Bullet/Shoot.queue_free()
		$Bullet.stop()
		$HPLifebar.hide()
		$"/root/Battle/Sounds".PlayGrunt(level / 2)
		dead = true
		$FSM.ChangeState("DEAD")
		$"Return to Idle".stop()
		$Chase.stop()
		$"../".GUI.EnemyDie()
		if BOSS:
			var tmp = Gun01.instance()
			tmp.global_position = self.global_position
			get_parent().add_child(tmp)
		if is_instance_valid($Word):
			$Word.queue_free()


func AVOIDS(pos):
	avoiding = true
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
