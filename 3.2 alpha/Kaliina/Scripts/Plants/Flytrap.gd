extends StaticBody

var ready = false

func _ready():
	pass # Replace with function body.


func _on_Area_body_entered(body):
	if body.is_in_group("Enemy") and ready:
		$"AnimationPlayer".play("Attack")
		body.Hurt(3, 5)

func SetReady():
	ready = true
