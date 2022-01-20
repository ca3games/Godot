extends Node2D

onready var midiout = GDRtMidiOut.new(GDRtMidiOut.Api.LINUX_ALSA, "Giano Remapper")

export(NodePath) var customscalecheck
onready var customcheck = get_node(customscalecheck)
export(NodePath) var customscalecodepath
onready var CustomScaleCode = get_node(customscalecodepath)
export(NodePath) var CCNodePath
onready var CCNode = get_node(CCNodePath)


export(NodePath) var PianoPath
onready var piano = get_node(PianoPath)
export(NodePath) var InfoPath
onready var Info = get_node(InfoPath)
export(NodePath) var KeysPath
onready var Keys = get_node(KeysPath)


func _ready():
	OS.open_midi_inputs()
	Info.get_node("Input").text = "MIDI INPUTS: " + str(OS.get_connected_midi_inputs())
	midiout.open_port(0, "Giano")
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
	Keys.get_node("Modes/Keys").add_item(name)

func AddMode(name):
	Keys.get_node("Modes/Mode").add_item(name)

func _unhandled_input(event):
	
	if event is InputEventMIDI:
		match event.message:
			MIDI_MESSAGE_NOTE_ON: 
				NoteOn(event.pitch, event.velocity)
			MIDI_MESSAGE_NOTE_OFF:
				NoteOff(event.pitch, event.velocity)
func _on_CustomScale_button_up():
	if customcheck.pressed:
		customcheck.get_node("../../Modes").hide()
	else:
		customcheck.get_node("../../Modes").show()

func NoteValues(pitch):
	var key
	var octave
	var scale_len
	if not customcheck.pressed:
		key = piano.GetKey(pitch, Keys.get_node("Modes/Keys").selected, Keys.get_node("Modes/Mode").selected)
		octave = pitch / 12
		scale_len = 12
	else:
		key = CustomScaleCode.GetKey(pitch)
		octave = pitch / len(CustomScaleCode.customscale.data["notes"])
		scale_len = len(CustomScaleCode.customscale.data["notes"])
	
	return Vector3(int(key), int(octave), int(scale_len))


func NoteOn(pitch, velocity):
	var key = NoteValues(pitch)
	
	if key.x != 999:
		if not customcheck.pressed:
			piano.get_node("Piano").TurnOn(pitch)
			piano.get_node("Altered").TurnOn(key.x)
		else:
			piano.get_node("Piano").TurnOnCustom(pitch)
			piano.get_node("Altered").TurnOnCustom(key.x)
		midiout.send_note_on(0, (key.y * key.z) + key.x, velocity)

func NoteOff(pitch, velocity):
	var key = NoteValues(pitch)
	if key.x != 999:
		if not customcheck.pressed:
			piano.get_node("Piano").TurnOff(pitch)
			piano.get_node("Altered").TurnOff(key.x)
		else:
			piano.get_node("Piano").TurnOffCustom(pitch)
			piano.get_node("Altered").TurnOffCustom(key.x)
		midiout.send_note_off(0, (key.y * key.z) + key.x, velocity)
