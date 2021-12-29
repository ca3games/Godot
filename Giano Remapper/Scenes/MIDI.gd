extends Node2D

onready var midiout = GDRtMidiOut.new(GDRtMidiOut.Api.LINUX_ALSA, "Godot Rtmidi")

export(NodePath) var PianoPath
onready var piano = get_node(PianoPath)
export(NodePath) var InfoPath
onready var Info = get_node(InfoPath)
export(NodePath) var KeysPath
onready var Keys = get_node(KeysPath)

func _ready():
	OS.open_midi_inputs()
	Info.get_node("Input").text = "MIDI INPUTS: " + str(OS.get_connected_midi_inputs())
	midiout.open_port(0, "Godot Rtmidi")
	Info.get_node("Output").text = "MIDI OUTPUT: " + str(midiout.get_port_count()) 
	AddScale()


func AddScale():
	AddKeys("C")
	AddKeys("C#")
	AddKeys("D")
	AddKeys("D#")
	AddKeys("E")
	AddKeys("F")
	AddKeys("F#")
	AddKeys("G")
	AddKeys("G#")
	AddKeys("A")
	AddKeys("A#")
	AddKeys("B")
	AddMode("Ionian")
	AddMode("Dorian")
	AddMode("Phrygian")
	AddMode("Lydian")
	AddMode("Myxolidian")
	AddMode("Aeolian")
	AddMode("Locrian")

func AddKeys(name):
	Keys.get_node("Key").add_item(name)

func AddMode(name):
	Keys.get_node("Mode").add_item(name)

func _unhandled_input(event):
	
	if event is InputEventMIDI:
		match event.message:
			MIDI_MESSAGE_NOTE_ON: 
				var key = piano.GetKey(event.pitch, Keys.get_node("Key").selected, Keys.get_node("Mode").selected)
				if key != 999:
					piano.get_node("Piano").TurnOn(event.pitch)
					piano.get_node("Altered").TurnOn(key)
					var octave = event.pitch / 12
					midiout.send_note_on(0, (octave * 12) + key, event.velocity)
			MIDI_MESSAGE_NOTE_OFF:
				piano.get_node("Piano").TurnOff(event.pitch)
				var key = piano.GetKey(event.pitch, Keys.get_node("Key").selected, Keys.get_node("Mode").selected)
				piano.get_node("Altered").TurnOff(key)
				var octave = event.pitch / 12
				midiout.send_note_off(0, (octave * 12) + key, 100)
