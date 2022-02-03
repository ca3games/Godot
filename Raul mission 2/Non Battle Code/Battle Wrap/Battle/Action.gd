extends Button

var action = "NONE"

func _on_Action_button_up():
	var child = get_parent().get_child_count()
	if child > 1:
		self.queue_free()
