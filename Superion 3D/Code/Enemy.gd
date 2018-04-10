extends RigidBody

var timer = -99
var left
var vel

func _ready():
	get_node("AnimationPlayer").play("IDLE")
	connect("body_enter", self, "_bounce")
	left = false
	vel = 2
	set_rotation(Vector3(0, 64.4, 0))
	set_translation(Vector3(get_translation().x, get_translation().y, Variables.z))
	set_fixed_process(true)
	
func _bounce(body):
	get_node("AnimationPlayer").play("Bounce")
	if body.get_name() == "Ball":
		timer = 5
	if body.get_name() == "Left":
		left = false
	if body.get_name() == "Right":
		left = true
	if body.is_in_group("Enemy"):
		left = !left
	if body.is_in_group("Hole"):
		get_tree().get_root().get_node("Spatial/SamplePlayer").play("enemy coin")
		Variables.score += 100
		self.queue_free()
	
func _fixed_process(delta):
	if timer > 0:
		timer -= delta * 2
	else:
		if left:
			set_linear_velocity(Vector3(-vel, 0, 0))
		else:
			set_linear_velocity(Vector3(vel, 0, 0))
	
func _stop():
	get_node("AnimationPlayer").play("IDLE")
