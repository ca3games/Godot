extends OptionButton

var id = 0

func _ready():
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	SetPort()


func _on_OutputPorts_item_selected(index):
	id = index


func _on_SetOutputPort_button_up():
	SetPort()
	
func SetPort():
	$"../PythonCode".ChangePort(id)
	$"../CurrentPortLabel".text = str(id) + " : " + $"../PythonCode".GetPortName(id)
