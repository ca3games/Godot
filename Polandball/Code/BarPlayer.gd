extends Sprite

func _ready():
	if get_node("..").is_in_group("P1"):
		self.set_modulate(Color(1,0,0))
	else:
		self.set_modulate(Color(0,0,1))