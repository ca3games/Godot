extends KinematicBody2D

export(NodePath) var BulletManagerPath
onready var BulletManager = get_node(BulletManagerPath)

var bullet = false


func _on_OffsetBullets_timeout():
	bullet = false
