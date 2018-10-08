extends Node2D

var x
var y

func _ready():
	pass


func _red():
	$AnimationPlayer.play("red_step")
	
func _white():
	$AnimationPlayer.play("white_step")
