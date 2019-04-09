extends Node2D

func _ready():
	$Button.hide()
	$Progress.show()
	
	$Progress.value = 0

func _bounce(number):
	$Progress.value += number
	if $Progress.value >= $Progress.max_value:
		$Button.show()
		$Progress.value = 0
		$Progress.hide()

func _Button_pressed():
	Variables.Special()
	$Progress.value = 0
	$Button.hide()
	$Progress.show()
	get_tree().get_root().get_node("Root/Ball")._Super()
