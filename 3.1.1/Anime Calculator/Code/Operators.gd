extends HBoxContainer

var calculator

func _ready():
	calculator = get_tree().get_root().get_node("Calculator")


func _on_Division_pressed():
	calculator.Operation("div")


func _on_Multi_pressed():
	calculator.Operation("multi")


func _on_Sub_pressed():
	calculator.Operation("minus")


func _on_Add_pressed():
	calculator.Operation("add")


func _on_sqrt_pressed():
	calculator.Operation("sqrt")


func _on_percent_pressed():
	calculator.Operation("perc")


func _on_result_pressed():
	calculator.Result()
