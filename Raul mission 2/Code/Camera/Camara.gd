extends InterpolatedCamera



func _on_Area_body_entered(body):
	self.enabled = false




func _on_Area_body_exited(body):
	self.enabled = true
