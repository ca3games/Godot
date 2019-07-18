extends Node2D

func _ready():
	self.position = Vector2(99999,99999)

func _process(delta):
	if Input.is_action_just_released("CLICK"):
		self.position = Vector2(99999,99999)
	
	if Input.is_action_just_released("RIGTH_CLICK"):
		self.position = get_global_mouse_position()