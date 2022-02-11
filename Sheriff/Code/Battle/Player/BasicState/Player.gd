extends KinematicBody2D

export (NodePath) var SceneRootPath
onready var SceneRoot = get_node(SceneRootPath)

export(NodePath) var BulletManagerPath
onready var BulletManager = get_node(BulletManagerPath)
