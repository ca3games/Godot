extends RigidBody
var left = false
var top =  true
var vel = 5
var speed = Vector2(0,0)
var time = -99
var red = false

var red_texture = preload ("res://2D/ball red.tex")
var blue_texture = preload ("res://3D/ball.tex")
var bounce = preload("res://Scenes/bounce.tscn")
var spark = preload("res://Scenes/bouncespark.tscn")

func _ready():
	set_translation(Vector3(get_translation().x, get_translation().y, Variables.z))
	connect("body_enter", self, "_bodyenter")
	get_node("AnimationPlayer").play("IDLE")
	speed = Vector2(vel, vel)
	set_fixed_process(true)
	set_process(true)
	
func _bodyenter(body):
	if body.get_name() == "Right":
		left = true
		Variables.score += 10
		Variables._barbounce(5)
		_spawnbounce()
	if body.get_name() == "Left":
		left = false
		Variables.score += 10
		Variables._barbounce(5)
		_spawnbounce()
	if body.get_name() == "Top":
		top = false
		Variables.score += 10
		Variables._barbounce(5)
		_spawnbounce()
	if body.get_name() == "Bottom":
		Variables._gameover()
	if body.is_in_group("Enemy"):
		_spark()
		left = !left
		Variables.score += 5
		if time > 0:
			body.queue_free()
			Variables.score += 100
			get_tree().get_root().get_node("Spatial/SamplePlayer").play("enemy coin")
	if body.get_name() == "Player":
		top = !top
		left = !body.right
		Variables.score += 8
		Variables._barbounce(8)
		_spark()
	set_angular_velocity(Vector3(0,0,0))
	get_node("AnimationPlayer").play("Bounce")
	get_node("../Camera")._shake()
	if body.is_in_group("Enemy"):
		get_tree().get_root().get_node("Spatial/SamplePlayer").play("bounce enemy")
	else:
		get_tree().get_root().get_node("Spatial/SamplePlayer").play("bounce ball")

func _stopbounce():
	get_node("AnimationPlayer").play("IDLE")

func _fixed_process(delta):
	if left:
		speed.x = -vel
	else:
		speed.x = vel
	if top:
		speed.y = vel
	else:
		speed.y = -vel
	
	set_linear_velocity(Vector3 (speed.x, speed.y, 0))
	
func _process(delta):
	if time > 0:
		time -= delta
	else:
		if red:
			print ("not red")
			get_node("MeshInstance").get_mesh().surface_get_material(0).set_texture(0, blue_texture)
			red = false
	
func _super():
	time = 2
	get_node("MeshInstance").get_mesh().surface_get_material(0).set_texture(0, red_texture)
	red = true
	
func _spawnbounce():
	var e = bounce.instance()
	e.set_translation(self.get_translation())
	get_node("../Bounce").add_child(e)
	
func _spark():
	var e = spark.instance()
	e.set_translation(self.get_translation())
	get_node("../Bounce").add_child(e)