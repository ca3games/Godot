extends KinematicBody2D

export(NodePath) var EnemyManagerPath
onready var EnemyManager = get_node(EnemyManagerPath)

onready var speed = 0
var d = 0.1
export (float) var move
var direction = 0
export(float) var inertia

func _ready():
	pass

func _process(delta):
	d = delta

func _input(event):
	if event is InputEventScreenDrag:
		speed = event.speed.x

func _physics_process(delta):
	speed += (speed * -1) * 0.3
	if speed != 0:
		if speed < 0:
			direction = -1
		if speed > 1:
			direction = 1
	else:
		direction = 0
	if abs(speed) < inertia:
		direction = 0
	var collision  = move_and_collide(Vector2(move * direction * delta, 0), false)
	
	if collision:
		if collision.collider.is_in_group("ENEMY"):
			collision.collider.Damage(500)
