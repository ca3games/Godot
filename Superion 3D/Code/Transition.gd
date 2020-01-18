extends Node2D


func _ready():
	get_tree().set_pause(true)
	_open()
	
func _open():
	get_node("AnimationPlayer").play("Open")
	
func _close():
	get_tree().set_pause(true)
	get_node("AnimationPlayer").play("Close")
	
func _finish():
	get_tree().set_pause(false)
	
func _closefinish():
	get_tree().set_pause(false)
	Variables._endlevel()
