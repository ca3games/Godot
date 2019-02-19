extends Area

func _MeleeHit(body):
	if body.is_in_group("Mamerto"):
		body._ChangeStatus("dead")
