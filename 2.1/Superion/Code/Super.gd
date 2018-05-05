extends TextureProgress


func _ready():
	pass

func _hit():
	var value = self.get_value()
	value += 5
	self.set_value(value)
	if self.get_value() >= 100:
		self.hide()
		get_tree().get_root().get_node("Node2D/superbutton").show()