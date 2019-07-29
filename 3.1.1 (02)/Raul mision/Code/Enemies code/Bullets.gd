extends Sprite

var direction

func _process(delta):
	position += direction.normalized()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Hero"):
		body.Hit()
		$"../../Scripts/Variables".Hit(-15)
