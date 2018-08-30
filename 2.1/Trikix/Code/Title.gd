extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _pressed():
	Values.fanfare()
	get_tree().change_scene("res://Scenes/Map.tscn")
