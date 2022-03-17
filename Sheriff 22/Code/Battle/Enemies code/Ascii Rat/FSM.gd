extends Node2D

export(NodePath) var RootPath
onready var Root = get_node(RootPath)

export(PackedScene) var bullet

export(NodePath) var AnimPath
onready var Anim = get_node(AnimPath)

onready var current = $IDLE

func _physics_process(delta):
	current.Physics(delta)

func Chase():
	print("CHASE")
	current = $CHASE
func Idle():
	current = $IDLE


func _on_Chase_timeout():
	Chase()

func _on_IDLE_timeout():
	Idle()
	if Root.ischasing:
		$IDLE/Shoot.start(3)

func SpawnBullet():
	var b = bullet.instance()
	b.global_position = Root.global_position
	b.speed = Root.bulletvel
	b.direction = Root.global_position - Root.get_parent().Player.global_position
	Root.get_parent().EnemyBulletsManager.add_child(b)

func ReturntoIdle():
	Anim.play("IDLE")

func _on_Shoot_timeout():
	Anim.play("Shoot")
