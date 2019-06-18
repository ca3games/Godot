extends Camera

var speed = Vector2(0,0)
var vel = 0.5

func _ready():
	pass # Replace with function body.

func _process(delta):
	speed = Vector2(0,0)
	if Input.is_action_pressed("CAMERALEFT"):
		speed.x = -vel
	if Input.is_action_pressed("CAMERARIGHT"):
		speed.x = vel
	if Input.is_action_pressed("CAMERAUP"):
		speed.y = -vel
	if Input.is_action_pressed("CAMERADOWN"):
		speed.y = vel
	
	self.global_translate(Vector3(speed.x, 0, speed.y))