extends StaticBody

var life = 0

func _ready():
	pass

func Change_HP():
	life += 1
	var RGB = 255
	match (life):
		1 : RGB = 177
		2 : RGB = 115
		3 : RGB = 55
		4 : self.queue_free()
	
	$"MeshInstance".get_surface_material(0).albedo_color = Color8(RGB, RGB, RGB, 255)
