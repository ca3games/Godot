extends Node2D

func dead():
	get_tree().get_root().get_node("Root/Enemies").Killed()
	self.queue_free()
