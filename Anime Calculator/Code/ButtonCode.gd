extends VBoxContainer

func AddNumber(number):
	get_tree().get_root().get_node("Calculator").AddNumber(number)


func _on_7_pressed():
	AddNumber(7)
func _on_8_pressed():
	AddNumber(8)
func _on_9_pressed():
	AddNumber(9)
func _on_4_pressed():
	AddNumber(4)
func _on_5_pressed():
	AddNumber(5)
func _on_6_pressed():
	AddNumber(6)
func _on_1_pressed():
	AddNumber(1)
func _on_2_pressed():
	AddNumber(2)
func _on_3_pressed():
	AddNumber(3)
func _on_0_pressed():
	AddNumber(0)

func _on_C_pressed():
	get_tree().get_root().get_node("Calculator").Clean()
func _on_AC_pressed():
	get_tree().get_root().get_node("Calculator").AllClean()

func _on_dot_pressed():
	get_tree().get_root().get_node("Calculator").AddDot()

func _on_negative_pressed():
	get_tree().get_root().get_node("Calculator").Negative()

func _on_back_pressed():
	get_tree().get_root().get_node("Calculator").BackSpace()
