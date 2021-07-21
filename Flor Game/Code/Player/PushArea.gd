extends Area

export (float) var Pushforce
export (float) var PushY


func _on_Area_body_entered(body):
	body.HIT()
	body.last_hit = "PLAYER"
	body.falling = true
	var angle = (body.transform.origin - $"../".transform.origin).normalized()
	angle *= Pushforce
	angle.y = PushY
	body.apply_impulse(Vector3.DOWN, angle)
