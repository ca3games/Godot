extends Node2D

onready var midiout = GDRtMidiOut.new(GDRtMidiOut.Api.LINUX_ALSA, "Godot Rtmidi")

export(NodePath) var PianoPath
onready var piano = get_node(PianoPath)
export(NodePath) var InfoPath
onready var Info = get_node(InfoPath)

func _ready():
	OS.open_midi_inputs()
	Info.get_node("Input").text = "MIDI INPUTS: " + str(OS.get_connected_midi_inputs())
	midiout.open_port(0, "Godot Rtmidi")
	Info.get_node("Output").text = "MIDI OUTPUT: " + str(midiout.get_port_count()) 

func _process(delta):
	pass
	

func _unhandled_input(event):
	
	if event is InputEventMIDI:
		match event.message:
			MIDI_MESSAGE_NOTE_ON: 
				piano.TurnOn(event.pitch)
				midiout.send_note_on(0, event.pitch, event.velocity)
			MIDI_MESSAGE_NOTE_OFF:
				piano.TurnOff(event.pitch)
				midiout.send_note_off(0, event.pitch, 100)
