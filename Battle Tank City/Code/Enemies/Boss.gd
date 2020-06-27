extends KinematicBody

var life = 0

func _ready():
	pass

func Change_HP():
	life += 1
	
	$MeshInstance.get_surface_material(0).set("shader_param/HP_texture", life)
	
	if life == 4:
		self.queue_free()
