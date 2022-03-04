extends Control

onready var current = $Gun

func _ready():
	pass # Replace with function body.

func TURNON():
	current.TURNON()
	
func TURNOFF():
	current.TURNOFF()
