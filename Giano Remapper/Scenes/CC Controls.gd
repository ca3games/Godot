extends Tabs

export(NodePath) var MIDIpath
onready var MIDI = get_node(MIDIpath)


func _on_CheckButton_button_up():
	$XYPad.recording = !$XYPad.recording

func _process(delta):
	if Input.is_action_just_released("SPACE"):
		$XYPad.recording = !$XYPad.recording
		$Record/HBoxContainer/CheckButton.pressed = !$Record/HBoxContainer/CheckButton.pressed
