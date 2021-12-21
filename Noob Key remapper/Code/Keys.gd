extends Node2D

export (NodePath) var PythonCodePath
onready var PythonCode = get_node(PythonCodePath)

func _unhandled_input(event : InputEvent):
	if (event is InputEventMIDI):
		
		match event.message:
			MIDI_MESSAGE_NOTE_ON:
				PythonCode.note_on(event.pitch)
			MIDI_MESSAGE_NOTE_OFF:
				PythonCode.note_off(event.pitch)
