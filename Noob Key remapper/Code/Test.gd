extends Node2D


func _ready():
	pass

func _on_C_button_up():
	$"../PythonCode".note_off(50)


func _C_button_down():
	$"../PythonCode".note_on(50)


func _on_Button2_button_down():
	$"../PythonCode".note_on(55)


func _on_Button2_button_up():
	$"../PythonCode".note_off(55)


func _on_Button3_button_down():
	$"../PythonCode".note_on(61)


func _on_Button3_button_up():
	$"../PythonCode".note_off(61)
