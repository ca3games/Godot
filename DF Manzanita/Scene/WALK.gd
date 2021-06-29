extends Node

signal apple_killed
var both = 0
var wall = false

onready var apple = $"../../../Generator/Apple"
onready var Root = $"../../"

onready var lenght = $"../../../Generator/Right".global_position.x - $"../../../Generator/Left".global_position.x

var time_out

func _ready():
	var generator = $"../Generator"
	self.connect("apple_killed", generator, "_apple_killed")

func Update(delta):
	var x = 0
	
	var left = false
	var right = false
	
	var distance = abs(Root.global_position.x - apple.global_position.x)
	var dist_nor = 1 - (distance / lenght)
	
	if Input.is_action_pressed("LEFT"):
		left = true
		
	if Input.is_action_pressed("RIGHT"):
		right = true
		
	if left and !right:
		x = -1
	if right and !left:
		x = 1
		
	if left and right:
		both = 0
	else:
		both = 1
	
	if x != 0 and time_out:
		time_out = false
		
		if x == 1 and !wall:
			Input.start_joy_vibration(0, dist_nor, 0, 0.2)
		if x == -1 and !wall:
			Input.start_joy_vibration(0, 0, dist_nor, 0.2)
	
	if $"../".speed_x != x and x != 0:
		$"../".flip(x)
	
	if x == 0:
		$"../".ChangeState("IDLE")
	
func Physics(delta):
	
	if $"../../AnimationPlayer".current_animation != "Walk":
		$"../../AnimationPlayer".play("Walk")
		
	var colision = $"../../".move_and_collide(Vector2($"../".speed_x * $"../".speed * delta * both, 0))
	if colision and colision.collider.is_in_group("Apple"):
		emit_signal("apple_killed")
		$"../".GOL()
	if colision and colision.collider.is_in_group("Wall"):
		wall = true
	else:
		wall = false



func _on_Timer_timeout():
	time_out = true
