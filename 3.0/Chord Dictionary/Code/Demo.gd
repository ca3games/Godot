extends Node2D

var Piano
var Sheet
var Name
var Major

enum escala { C, D, E, F, G, A, B, Db, Eb, Gb, Ab, Bb}
var current = escala.C

func _ready():
	Major = true
	Piano = get_node("Piano/scale")
	Sheet = get_node("Sheet/AnimationPlayer")
	Name = get_node("ScaleName")
	_ScaleMajor()
	_MajorChord()

func _input(event):
	if Input.is_action_pressed("UP"):
		_MAYOR()
		
	if Input.is_action_pressed("DOWN"):
		_MINOR()
	
	if Input.is_action_just_pressed("LEFT"):
		_LEFT()
	if Input.is_action_just_pressed("RIGHT"):
		_RIGHT()

func _LEFT():
	leftMajor()
	if Major:
		_ScaleMajor()
	else:
		_ScaleMinor()
	
func _RIGHT():
	rightMajor()
	if Major:
		_ScaleMajor()
	else:
		_ScaleMinor()
	
func _MINOR():
	Major = false
	_ScaleMinor()
	
func _MAYOR():
	Major = true
	_ScaleMajor()

func _ScaleMinor():
	match current:
		escala.C: 
			Piano._minor("Cm")
			Sheet.play("Cm")
			Name.text = "C min"
		escala.Db:
			Piano._minor("Dbm")
			Sheet.play("C#m")
			Name.text = "Db min"
		escala.D:
			Piano._minor("Dm")
			Sheet.play("Dm")
			Name.text = "D min"
		escala.Eb:
			Piano._minor("Ebm")
			Sheet.play("D#m")
			Name.text = "Eb min"
		escala.E:
			Piano._minor("Em")
			Sheet.play("Em")
			Name.text = "E min"
		escala.F:
			Piano._minor("Fm")
			Sheet.play("Fm")
			Name.text = "F min"
		escala.Gb:
			Piano._minor("Gbm")
			Sheet.play("F#m")
			Name.text = "Gb min"
		escala.G:
			Piano._minor("Gm")
			Sheet.play("Gm")
			Name.text = "G min"
		escala.Ab:
			Piano._minor("Abm")
			Sheet.play("G#m")
			Name.text = "Ab min"
		escala.A:
			Piano._minor("Am")
			Sheet.play("Am")
			Name.text = "A min"
		escala.Bb:
			Piano._minor("Bbm")
			Sheet.play("A#m")
			Name.text = "Bb min"
		escala.B:
			Piano._minor("Bm")
			Sheet.play("Bm")
			Name.text = "B min"


func _ScaleMajor():
	match current:
		escala.C: 
			Piano._major("C")
			Sheet.play("C")
			Name.text = "C"
		escala.Db:
			Piano._major("Db")
			Sheet.play("C#")
			Name.text = "Db"
		escala.D:
			Piano._major("D")
			Sheet.play("D")
			Name.text = "D"
		escala.Eb:
			Piano._major("Eb")
			Sheet.play("D#")
			Name.text = "Eb"
		escala.E:
			Piano._major("E")
			Sheet.play("E")
			Name.text = "E"
		escala.F:
			Piano._major("F")
			Sheet.play("F")
			Name.text = "F"
		escala.Gb:
			Piano._major("Gb")
			Sheet.play("F#")
			Name.text = "Gb"
		escala.G:
			Piano._major("G")
			Sheet.play("G")
			Name.text = "G"
		escala.Ab:
			Piano._major("Ab")
			Sheet.play("G#")
			Name.text = "Ab"
		escala.A:
			Piano._major("A")
			Sheet.play("A")
			Name.text = "A"
		escala.Bb:
			Piano._major("Bb")
			Sheet.play("A#")
			Name.text = "Bb"
		escala.B:
			Piano._major("B")
			Sheet.play("B")
			Name.text = "B"

func rightMajor():
	match current:
		escala.C: current = escala.Db
		escala.Db: current = escala.D
		escala.D: current = escala.Eb
		escala.Eb: current = escala.E
		escala.E: current = escala.F
		escala.F: current = escala.Gb
		escala.Gb: current = escala.G
		escala.G: current = escala.Ab
		escala.Ab: current = escala.A
		escala.A: current = escala.Bb
		escala.Bb: current = escala.B
		escala.B: current = escala.C

func leftMajor():
	match current:
		escala.C: current = escala.B
		escala.Db: current = escala.C
		escala.D: current = escala.Db
		escala.Eb: current = escala.D
		escala.E: current = escala.Eb
		escala.F: current = escala.E
		escala.Gb: current = escala.F
		escala.G: current = escala.Gb
		escala.Ab: current = escala.G
		escala.A: current = escala.Ab
		escala.Bb: current = escala.A
		escala.B: current = escala.Bb

func _on_Left_pressed():
	_LEFT()

func _on_Right_pressed():
	_RIGHT()
	
func _on_Mayor_pressed():
	_MAYOR()

func _on_Minor_pressed():
	_MINOR()

func _cleanChords():
	$"Chords/acordes mayores-1".hide()
	$"Chords/aumented-1".hide()
	$"Chords/disminished-1".hide()
	$"Chords/acordes menores-1".hide()
	$"Chords/dominante majores-1".hide()

func _MajorChord():
	_cleanChords()
	$"Chords/acordes mayores-1".show()


func _minorChords():
	_cleanChords()
	$"Chords/acordes menores-1".show()
	

func _DominantChord():
	_cleanChords()
	$"Chords/dominante majores-1".show()


func _aumentedChords():
	_cleanChords()
	$"Chords/aumented-1".show()


func _DisminishedChords():
	_cleanChords()
	$"Chords/disminished-1".show()
