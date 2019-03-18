extends ImmediateGeometry

onready var begin = $"../Pistol"
onready var end = $"../Helper"
onready var Ray = $"../HelperRaycast"

func _process(delta):
	Ray.force_raycast_update()
	
	var color = Color8(255,255,0,255)
	
	if Ray.is_colliding():
		var body = Ray.get_collider()
		if body.is_in_group("Enemies"):
			color = Color8(255,0,0,255)
	
	self.material_override.set("albedo_color", color)	
	clear()
	begin(Mesh.PRIMITIVE_LINES)
	add_vertex(begin.transform.origin)
	add_vertex(end.transform.origin)
	end()

