extends Camera

var player_out = false
export (float) var speed
export (NodePath) var Pacifica
export (float) var offset

func _process(delta):
	if player_out:
		
		var player = get_node(Pacifica)
		var player_pos = player.global_transform.origin
		var center_pos = $"Center".global_transform.origin
		var direction = Vector2.ZERO
		if abs(center_pos.x - player_pos.x) > 2:
			if center_pos.x - player_pos.x < 0:
				direction.x = 1
			else:
				direction.x = -1
		if abs(center_pos.z - player_pos.z) > 2:
			if center_pos.z - player_pos.z < 0:
				direction.y = 1
			else:
				direction.y = -1
		var final_speed = Vector3(direction.x * speed, 0, direction.y * speed)
		translation += final_speed * delta

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		player_out = true


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		player_out = false
