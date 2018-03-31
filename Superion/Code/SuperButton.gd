extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("pressed", self, "_super")
	pass

func _super():
	self.hide()
	get_tree().get_root().get_node("Node2D/SUPER").show()
	get_tree().get_root().get_node("Node2D/SUPER").set_value(0)
	get_tree().get_root().get_node("Node2D/Ball")._power()