extends Position2D

signal apple_killed

var pos

func _ready():
	self.connect("apple_killed", self, "_apple_killed")
	var pos_x = rand_range($Left.position.x, $Right.position.x)
	$Apple.pos = pos_x
	$Apple.offset = self.position.x
	_apple_killed()


func _apple_killed():
	var pos_x = rand_range($Left.position.x, $Right.position.x)
	$Apple.pos = Vector2(pos_x, self.position.y)
	$Apple.teleport = true
	$"../CanvasLayer/TextureProgress/Timer".start(8)
	$"../AnimationPlayer".play("Fanfare")

