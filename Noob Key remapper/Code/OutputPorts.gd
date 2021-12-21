extends OptionButton

var id = 0

export (NodePath) var PythonCodePath
onready var PythonCode = get_node(PythonCodePath)
export(NodePath) var OutPutLabelPath
onready var OutPutLabel = get_node(OutPutLabelPath)

func _ready():
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	SetPort()


func _on_OutputPorts_item_selected(index):
	id = index


func _on_SetOutputPort_button_up():
	SetPort()
	
func SetPort():
	PythonCode.ChangePort(id)
	OutPutLabel.text = str(id) + " : " + PythonCode.GetPortName(id)
