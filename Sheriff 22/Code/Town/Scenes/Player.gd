extends Sprite3D

export(float) var Speed

func _ready():
	pass

func _process(delta):
	var angle = Vector2.ZERO
	
	if Input.is_action_pressed("LEFT"):
		angle.x = 1
	if Input.is_action_pressed("RIGHT"):
		angle.x = -1
	if Input.is_action_pressed("UP"):
		angle.y = 1
	if Input.is_action_pressed("DOWN"):
		angle.y = -1
		
	self.global_transform.origin += Vector3(angle.x, 0, angle.y) * Speed * delta
