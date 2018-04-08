extends TextureButton

func _ready():
	connect("pressed", self, "_specialbutton")
	set_process_input(true)
	
func _specialbutton():
	Variables._super()
	
func _input(event):
	if Input.is_action_pressed("POWER"):
		if self.is_visible():
			Variables._super()
