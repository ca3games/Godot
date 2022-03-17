extends Node2D

export (NodePath) var UpRightPath
onready var upright = get_node(UpRightPath)
export (NodePath) var UpPath
onready var up = get_node(UpPath)
export(NodePath) var SidePath
onready var side = get_node(SidePath)
export(NodePath) var DownRightPath
onready var downright = get_node(DownRightPath)
export(NodePath) var DownPath
onready var down = get_node(DownPath)


func _on_DownRight_body_entered(body):
	if body.is_in_group("ENEMY"):
		body.AVOIDS(downright.global_position)

func _on_Down_body_entered(body):
	if body.is_in_group("ENEMY"):
		body.AVOIDS(down.global_position)


func _on_Side_body_entered(body):
	if body.is_in_group("ENEMY"):
		body.AVOIDS(side.global_position)


func _on_UpRight_body_entered(body):
	if body.is_in_group("ENEMY"):
		body.AVOIDS(upright.global_position)


func _on_Up_body_entered(body):
	if body.is_in_group("ENEMY"):
		body.AVOIDS(up.global_position)
