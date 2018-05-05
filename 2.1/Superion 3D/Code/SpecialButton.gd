extends TextureButton

func _ready():
	connect("pressed", self, "_specialbutton")
	set_process_input(true)
	
func _specialbutton():
	Variables._super()
	
func _input(event):
	if Input.is_action_pressed("POWER"):
		if self.is_visible():
			get_tree().get_root().get_node("Spatial/SamplePlayer").play("super")
			Variables._super()
