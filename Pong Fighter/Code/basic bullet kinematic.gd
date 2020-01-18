extends KinematicBody

export(bool) var P1
var speed
var vel = 10

func _ready():
	if P1:
		speed = vel
		self.set_collision_layer(2)
		self.set_collision_mask(2)
		$"basic bullet/Sphere".get_surface_material(0).albedo_color = Color.cyan
	else:
		speed = -vel
		self.set_collision_layer(1)
		self.set_collision_mask(1)
		$"basic bullet/Sphere".get_surface_material(0).albedo_color = Color.red

func _process(delta):
	var colision = move_and_collide(Vector3(speed, 0, 0) * delta)
	
	if colision:
		if colision.collider.is_in_group("Ball"):
			if P1:
				colision.collider.Reverse(true)
			else:
				colision.collider.Reverse(false)
			self.queue_free()
		
		if colision.collider.is_in_group("Wall"):
			self.queue_free()
		
		if colision.collider.is_in_group("Enemy"):
			colision.collider.Hit()
			if P1:
				$"../../GUI".ChangeHP(false, -10)
			else:
				$"../../GUI".ChangeHP(true, -10)
			self.queue_free()
		
		if P1 and colision.collider.is_in_group("P2"):
			$"../../GUI".ChangeHP(false, -5)
			self.queue_free()
		if !P1 and colision.collider.is_in_group("P1"):
			$"../../GUI".ChangeHP(true, -5)
			self.queue_free()


func _on_VisibilityNotifier_camera_exited(camera):
	self.queue_free()

func Delete():
	self.queue_free()
