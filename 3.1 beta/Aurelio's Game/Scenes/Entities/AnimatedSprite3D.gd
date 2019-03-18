extends AnimatedSprite3D

onready var mamerto_shader = preload("res://Shader/Mamerto shader.tres")

func ChangeColor(new_color):
	material_override = mamerto_shader.duplicate()
	material_override.set_shader_param("jacket", new_color)
	
func GetColor():
	return material_override.get_shader_param("jacket")
