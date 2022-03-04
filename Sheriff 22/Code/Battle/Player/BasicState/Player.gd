extends KinematicBody2D

export (NodePath) var SceneRootPath
onready var SceneRoot = get_node(SceneRootPath)

export(NodePath) var BulletManagerPath
onready var BulletManager = get_node(BulletManagerPath)

export(NodePath) var GUIPath
onready var GUI = get_node(GUIPath)

onready var AmmoBasic = Variables.ammobasic

onready var OffsetBody = $SpawnBulletPos.position

export(int) var kickdamage
var meleetype = "KICK"

func ReloadAmmo(x):
	AmmoBasic += x
	GUI.SetAmmoBasic(AmmoBasic)

func _on_Melee_body_entered(body):
	if body.is_in_group("TUMBLEWEED"):
		match(meleetype):
			"KICK" : body.Melee(1)
	if body.is_in_group("ENEMY"):
		match(meleetype):
			"KICK" : body.HIT(Variables.kicklevel * 2.5)
