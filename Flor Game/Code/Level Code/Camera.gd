extends InterpolatedCamera

func _process(delta):
	self.rotation_degrees = Vector3.ZERO


func _on_Area_body_entered(body):
	if body.is_in_group("PLAYER"):
		self.enabled = false


func _on_Area_body_exited(body):
	if body.is_in_group("PLAYER"):
		self.enabled = true
