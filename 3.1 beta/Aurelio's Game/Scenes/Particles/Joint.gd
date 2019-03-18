extends Area

func _ready():
	pass 

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		body._Hit(20)
		self.queue_free()


func _on_Timer_timeout():
	self.queue_free()
