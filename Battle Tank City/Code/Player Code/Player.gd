extends KinematicBody

var vel = 10
var speed = Vector2.ZERO
var old_speed = Vector2.UP
var idle = true

onready var Bullet = preload("res://Scenes/Player/Bullet.tscn")

func _ready():
	pass
	
func _process(delta):
	
	speed = Vector2.ZERO
	
	var left = false
	var right = false
	var top = false
	var bottom = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("UP"):
		top = true
	if Input.is_action_pressed("DOWN"):
		bottom = true
		
	if left and !right and !top and !bottom:
		speed = Vector2.LEFT
	if right and !left and !top and !bottom:
		speed = Vector2.RIGHT
	if top and !left and !right and !bottom:
		speed = Vector2.UP
	if bottom and !left and !right and !top:
		speed = Vector2.DOWN
	
	if speed != Vector2.ZERO:
		old_speed = speed
	
	if Input.is_action_just_released("SPACE") and idle:
		$"Bullet".start(1.5)
		idle = false
		var tmp = Bullet.instance()
		tmp.global_transform.origin = self.global_transform.origin
		tmp.direction = old_speed
		if old_speed == Vector2.UP or old_speed == Vector2.DOWN:
			tmp.get_node("Bullet").rotation = Vector3.ZERO
		$"../".add_child(tmp)

func _physics_process(delta):
	var v = speed * vel * delta
	var collision = move_and_collide(Vector3(v.x, 0, v.y))
	match (speed):
		Vector2.UP : set("rotation_degrees", Vector3(0, 0, 0))
		Vector2.DOWN : set("rotation_degrees", Vector3(0, 180, 0))
		Vector2.LEFT : set("rotation_degrees", Vector3(0, 90, 0))
		Vector2.RIGHT : set("rotation_degrees", Vector3(0, 270, 0))
	
	if collision:
		if collision.collider.is_in_group("Item"):
			collision.collider.queue_free()

func _on_Bullet_timeout():
	idle = true
