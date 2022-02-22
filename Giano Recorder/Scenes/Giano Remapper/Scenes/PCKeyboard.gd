extends VBoxContainer

export(NodePath) var MIDIpath
onready var MIDI = get_node(MIDIpath)

func _ready():
	$Volume.hide()

func _input(event):
	if not $HBoxContainer/CheckButton.pressed:
		return
	if event is InputEventKey:
		match (event.scancode):
			KEY_A: Key(60, event.pressed)
			KEY_W: Key(61, event.pressed)
			KEY_S: Key(62, event.pressed)
			KEY_E: Key(63, event.pressed)
			KEY_D: Key(64, event.pressed)
			KEY_F: Key(65, event.pressed)
			KEY_T: Key(66, event.pressed)
			KEY_G: Key(67, event.pressed)
			KEY_Y: Key(68, event.pressed)
			KEY_H: Key(69, event.pressed)
			KEY_U: Key(70, event.pressed)
			KEY_J: Key(71, event.pressed)

func Key(pitch, pressed):
	if pressed:
		MIDI.NoteOn(pitch, $Volume/Volume.value)
	else:
		MIDI.NoteOff(pitch, $Volume/Volume.value)


func _on_CheckButton_button_up():
	if $HBoxContainer/CheckButton.pressed:
		$Volume.show()
	else:
		$Volume.hide()
