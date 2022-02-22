extends Node2D

#onready var midiout = GDRtMidiOut.new(GDRtMidiOut.Api.LINUX_ALSA, "Giano Remapper")

export(NodePath) var KeyPath
onready var Keys = get_node(KeyPath)
export(NodePath) var ModePath
onready var Mode = get_node(ModePath)
onready var piano = $Piano
export(NodePath) var PianoRollPath
onready var PianoRoll = get_node(PianoRollPath)

func _ready():
	OS.open_midi_inputs()
	$Inputs.text = "MIDI INPUTS: " + str(OS.get_connected_midi_inputs())
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
	AddMode("Blues")

func AddKeys(name):
	Keys.add_item(name)

func AddMode(name):
	Mode.add_item(name)

func _unhandled_input(event):
	if event is InputEventMIDI:
		match event.message:
			MIDI_MESSAGE_NOTE_ON: 
				NoteOn(event.pitch, event.velocity)
				pass
			MIDI_MESSAGE_NOTE_OFF:
				#NoteOff(event.pitch, event.velocity)
				pass

func NoteValues(pitch):
	var key
	var octave
	var scale_len
	key = piano.GetKey(pitch, Keys.selected, Mode.selected)
	octave = pitch / 12
	scale_len = 12
	return Vector3(int(key), int(octave), int(scale_len))


func NoteOn(pitch, velocity):
	print("note on", pitch)
	var key = NoteValues(pitch)
	
	print("key", key)
	if key.x != 999:
		PianoRoll.AddNote(key.x)
		pass
		#midiout.send_note_on(0, (key.y * key.z) + key.x, velocity)

func NoteOff(pitch, velocity):
	var key = NoteValues(pitch)
	if key.x != 999:
		pass
		#midiout.send_note_off(0, (key.y * key.z) + key.x, velocity)
