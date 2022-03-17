extends KinematicBody2D

export(int) var Idle = 5
export(int) var Chase = 2
export(float) var distance = 50
export(float) var vel = 20
export(float) var bulletvel

var startingpos
onready var ischasing = false

func _ready():
	$IDLE.start(Idle)
	startingpos = self.global_position


func _on_Area2D_body_entered(body):
	if body.is_in_group("PLAYER"):
		$Chase.start(Chase)
		ischasing = true
