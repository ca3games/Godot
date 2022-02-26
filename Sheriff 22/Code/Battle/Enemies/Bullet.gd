extends Area2D

export(float) var speed
var direction = Vector2.DOWN
var damage = 5

func _physics_process(delta):
	self.position += direction * speed * -1


func _on_Bullet_body_entered(body):
	if body.is_in_group("TILEMAP"):
		queue_free()
	
	if body.is_in_group("PLAYER"):
		body.GUI.DamageLifebar(-damage)
		$"/root/Battle/Sounds".PlayPlayerHit()
		Variables.PlayerDamage(damage)
		queue_free()
