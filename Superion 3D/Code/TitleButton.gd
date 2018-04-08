extends TextureButton

func _ready():
	connect("pressed", self, "_onpress")
	set_process_input(true)
	
func _onpress():
	_StartGame()

func _StartGame():
	get_tree().change_scene("res://Scenes/main.tscn")
	
func _input(event):
	if Input.is_action_pressed("SPACE"):
		_StartGame()