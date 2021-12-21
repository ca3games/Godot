extends OptionButton

var id = 0

export (NodePath) var PythonCodePath
onready var PythonCode = get_node(PythonCodePath)
export(NodePath) var InputLabelPath
onready var InputLabel = get_node(InputLabelPath)

var inputs

func _ready():
	OS.open_midi_inputs()
	inputs = OS.get_connected_midi_inputs()
	
	for i in len(inputs):
		self.add_item(str(inputs[i], i))
	InputLabel.text = str(id) + " : " + str(inputs[id])
