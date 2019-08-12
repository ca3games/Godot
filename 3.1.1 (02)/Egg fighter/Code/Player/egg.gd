extends RigidBody

export (bool) var P1

func _ready():
	if P1 :
		$Body.rotation_degrees.y = 40
		$Body/Sphere.get_surface_material(1).albedo_color =  Color.blue
	else:
		$Body.rotation_degrees.y = -40
		$Body/Sphere.get_surface_material(1).albedo_color = Color.green