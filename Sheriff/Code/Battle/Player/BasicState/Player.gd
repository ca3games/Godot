extends KinematicBody2D

export (NodePath) var SceneRootPath
onready var SceneRoot = get_node(SceneRootPath)

export(NodePath) var BulletManagerPath
onready var BulletManager = get_node(BulletManagerPath)

export(NodePath) var GUIPath
onready var GUI = get_node(GUIPath)

onready var AmmoBasic = Variables.ammobasic

func ReloadAmmo(x):
	AmmoBasic += x
	GUI.SetAmmoBasic(AmmoBasic)


