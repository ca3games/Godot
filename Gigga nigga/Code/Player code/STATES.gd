extends Spatial

onready var Ani = $"../gigga nigga/AnimationPlayer"
onready var Root = $"../"

onready var current = $IDLE
var speed = Vector3.ZERO
var vel = 30
var facing = Vector2.ZERO
onready var mouse_relative = 0

var mouse_coord = 0
var mouse_rot = 0.04

func _ready():
	pass

func _process(delta):
	current.Update()
	
	match(mouse_coord):
		1: 
			if mouse_relative > 0:
				Root.rotate_y(-lerp(0, mouse_rot, mouse_relative/10))
		-1: 
			if mouse_relative < 0:
				Root.rotate_y(-lerp(0, mouse_rot, mouse_relative/10))


func _physics_process(delta):
	current.Physics(delta)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_relative = event.relative.x
		mouse_coord = 0
		if event.position.x < 200:
			mouse_coord = -1
		if event.position.x > 800:
			mouse_coord = 1
		
		if mouse_coord == 0:
			if event.relative.x > 0:
				Root.rotate_y(-lerp(0, mouse_rot, mouse_relative/10))
			elif event.relative.x < 0:
				Root.rotate_y(-lerp(0, mouse_rot, mouse_relative/10))

func ChangeState(state):
	match(state):
		"IDLE" :  current = $IDLE
		"WALK" :  current = $WALK
