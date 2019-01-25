extends ImmediateGeometry

onready var begin = $"../Pistol"
onready var end = $"../End"
onready var time = $Timer
onready var Ray = $"../RayCast"

var p_ray = false

func _draw():
	clear()
	begin(Mesh.PRIMITIVE_LINES)
	add_vertex(begin.transform.origin)
	add_vertex(end.transform.origin)
	end()
	time.start(0.1)
	
	p_ray = true

func _on_Timer_timeout():
	clear()

func _physics_process(delta):
	if p_ray:
		Ray.force_raycast_update()
		
		if Ray.is_colliding():
			var body = Ray.get_collider()
			
			if body.is_in_group("Enemies"):
				body.queue_free()
		
		p_ray = false