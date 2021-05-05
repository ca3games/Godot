extends RigidBody2D

signal apple_killed

var offset = 0
var pos = Vector2.ZERO
var teleport = false

func _ready():
	var generator = $"../"
	self.connect("apple_killed", generator, "_apple_killed")


func _on_Apple_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("apple_killed")
		$"../../".GOL()

func _integrate_forces(state):
	if teleport:
		state.linear_velocity = Vector2.ZERO
		var apple_pos = state.get_transform()
		pos.x += offset
		apple_pos.origin = pos
		state.set_transform(apple_pos)
		teleport = false
	
