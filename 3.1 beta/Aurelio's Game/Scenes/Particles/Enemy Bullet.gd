extends RigidBody

onready var shader = preload("res://Shader/Enemy Bullet.tres")
var speed

var color
var damage

func _ready():
	speed = self.global_transform.origin - get_tree().get_root().get_node("Spatial/Player").global_transform.origin
	speed = (speed.normalized() * Variables.bullet_speed) * -1
	$Sprite3D.material_override = shader.duplicate()

func _physics_process(delta):
	self.linear_velocity = speed
	

func _setColor(c):
	$Sprite3D.material_override.set("shader_param/albedo", c)
	color = c

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		if damage == -1:
			body._Hit(2)
		else:
			body._Hit(-damage)
		if color == Color8(5,3,215,255):
			body._Slow()
		if color == Color8(99,49,0,255):
			get_tree().get_root().get_node("Spatial/Canvas/Mana").value = 0
		self.queue_free()
	if body.is_in_group("Background") or body.is_in_group("Wall"):
		self.queue_free()


func _on_Timer_timeout():
	self.queue_free()
