extends RigidBody2D

func _ready():
	get_node("AnimationPlayer").play("IDLE")
	
	var h = randi()%4+1
	if h < 2:
		get_node("CollisionShape2D/Sprite").flip_h = true
	print(str(h))
	
func _process(delta):
	linear_velocity = Vector2(0,0)