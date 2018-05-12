extends RigidBody2D


func _ready():
	pass

func _grab(grab):
	if grab:
		self.queue_free()
		Variables.hearts += 1
		get_tree().get_root().get_node("Node2D/Coin").play()
		get_tree().get_root().get_node("Node2D/Hearts").set_text(str(Variables.hearts))

func _Timer():
	var value = get_tree().get_root().get_node("Node2D/Lifebar").get_value()
	get_tree().get_root().get_node("Node2D/Lifebar").set_value(value - 20)
	get_tree().get_root().get_node("Node2D/Lost").play()
	if value - 20 < 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")	
	self.queue_free()
