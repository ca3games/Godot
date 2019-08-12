extends Node

onready var current = $IDLE

func _ready():
	pass # Replace with function body.

func _process(delta):
	current.Update(delta)
	
func _physics_process(delta):
	current.Physics(delta)
