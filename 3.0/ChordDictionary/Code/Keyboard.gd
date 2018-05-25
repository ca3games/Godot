extends Node2D

var root = Color(1, 0, 0, 1)
var V = Color (0.8, 0.2, 0, 0.9)
var iii = Color (1, 1, 0, 0.9)
var white = Color(255,255,255,255)
var gray = Color(0.5,0.5,0.5,0.1)

var C
var Db
var D
var Eb
var E
var F
var Gb
var G
var Ab
var A
var Bb
var B

func _ready():
	C = get_node("C")
	Db = get_node("C#")
	D = get_node("D")
	Eb = get_node("D#")
	E = get_node("E")
	F = get_node("F")
	Gb = get_node("F#")
	G = get_node("G")
	Ab = get_node("G#")
	A = get_node("A")
	Bb = get_node("A#")
	B = get_node("B")
	_major("C")
	

func _major(scale):
	_setscale()
	match scale:
		"C": _Cmajor()
		"D": _Dmajor()
		"E": _Emajor()
		"F": _Fmajor()
		"G": _Gmajor()
		"A": _Amajor()
		"B": _Bmajor()
		"Db": _Dbmajor()
		"Eb": _Ebmajor()
		"Gb": _Gbmajor()
		"Ab": _Abmajor()
		"Bb": _Bbmajor()

func _minor(scale):
	_setscale()
	match scale:
		"Cm": _Cminor()
		"Dm": _Dminor()
		"Em": _Eminor()
		"Fm": _Fminor()
		"Gm": _Gminor()
		"Am": _Aminor()
		"Bm": _Bminor()
		"Dbm": _Dbminor()
		"Ebm": _Ebminor()
		"Gbm": _Gbminor()
		"Abm": _Abminor()
		"Bbm": _Bbminor()

func _setscale():
	C.modulate = gray
	Db.modulate = gray
	D.modulate = gray
	Eb.modulate = gray
	E.modulate = gray
	F.modulate = gray
	Gb.modulate = gray
	G.modulate = gray
	Ab.modulate = gray
	A.modulate = gray
	Bb.modulate = gray
	B.modulate = gray

func _Cmajor():
	C.modulate = root
	D.modulate = white
	E.modulate = iii
	F.modulate = white
	G.modulate = V
	A.modulate = white
	B.modulate = white
	
func _Dmajor():
	D.modulate = root
	E.modulate = white
	Gb.modulate = iii
	G.modulate = white
	A.modulate = V
	B.modulate = white
	Db.modulate = white

func _Emajor():
	E.modulate = root
	Gb.modulate = white
	Ab.modulate = iii
	A.modulate = white
	B.modulate = V
	Db.modulate = white
	Eb.modulate = white

func _Fmajor():
	F.modulate = root
	G.modulate = white
	A.modulate = iii
	Bb.modulate = white
	C.modulate = V
	D.modulate = white
	E.modulate = white

func _Gmajor():
	G.modulate = root
	A.modulate = white
	B.modulate = iii
	C.modulate = white
	D.modulate = V
	E.modulate = white
	Gb.modulate = white
	
func _Amajor():
	A.modulate = root
	B.modulate = white
	Db.modulate = iii
	D.modulate = white
	E.modulate = V
	Gb.modulate = white
	Ab.modulate = white
	
func _Bmajor():
	B.modulate = root
	Db.modulate = white
	Eb.modulate = iii
	E.modulate = white
	Gb.modulate = V
	Ab.modulate = white
	Bb.modulate = white
	
func _Dbmajor():
	Db.modulate = root
	Eb.modulate = white
	F.modulate = iii
	Gb.modulate = white
	Ab.modulate = V
	Bb.modulate = white
	C.modulate = white

func _Ebmajor():
	Eb.modulate = root
	F.modulate = white
	G.modulate = iii
	Ab.modulate = white
	Bb.modulate = V
	C.modulate = white
	D.modulate = white
	
func _Gbmajor():
	Gb.modulate = root
	Ab.modulate = white
	Bb.modulate = iii
	B.modulate = white
	Db.modulate = V
	Eb.modulate = white
	F.modulate = white

func _Abmajor():
	Ab.modulate = root
	Bb.modulate = white
	C.modulate = iii
	Db.modulate = white
	Eb.modulate = V
	F.modulate = white
	G.modulate = white

func _Bbmajor():
	Bb.modulate = root
	C.modulate = white
	D.modulate = iii
	Eb.modulate = white
	F.modulate = V
	G.modulate = white
	A.modulate = white
	
func _Cminor():
	C.modulate = root
	D.modulate = white
	Eb.modulate = iii
	F.modulate = white
	G.modulate = V
	Ab.modulate = white
	Bb.modulate = white

func _Dminor():
	D.modulate = root
	E.modulate = white
	F.modulate = iii
	G.modulate = white
	A.modulate = V
	Bb.modulate = white
	C.modulate = white

func _Eminor():
	E.modulate = root
	Gb.modulate = white
	G.modulate = iii
	A.modulate = white
	B.modulate = V
	C.modulate = white
	D.modulate = white
	
func _Fminor():
	F.modulate = root
	G.modulate = white
	Ab.modulate = iii
	Bb.modulate = white
	C.modulate = V
	Db.modulate = white
	Eb.modulate = white
	
func _Gminor():
	G.modulate = root
	A.modulate = white
	Bb.modulate = iii
	C.modulate = white
	D.modulate = V
	Eb.modulate = white
	F.modulate = white

func _Aminor():
	A.modulate = root
	B.modulate = white
	C.modulate = iii
	D.modulate = white
	E.modulate = V
	F.modulate = white
	G.modulate = white

func _Bminor():
	B.modulate = root
	Db.modulate = white
	D.modulate = iii
	E.modulate = white
	Gb.modulate = V
	G.modulate = white
	A.modulate = white
	
func _Dbminor():
	Db.modulate = root
	Eb.modulate = white
	E.modulate = iii
	Gb.modulate = white
	Ab.modulate = V
	A.modulate = white
	B.modulate = white

func _Ebminor():
	Eb.modulate = root
	F.modulate = white
	Gb.modulate = iii
	Ab.modulate = white
	Bb.modulate = V
	B.modulate = white
	Db.modulate = white
	
func _Gbminor():
	Gb.modulate = root
	Ab.modulate = white
	A.modulate = iii
	B.modulate = white
	Db.modulate = V
	D.modulate = white
	E.modulate = white

func _Abminor():
	Ab.modulate = root
	Bb.modulate = white
	B.modulate = iii
	Db.modulate = white
	Eb.modulate = V
	E.modulate = white
	Gb.modulate = white
	
func _Bbminor():
	Bb.modulate = root
	C.modulate = white
	Db.modulate = iii
	Eb.modulate = white
	F.modulate = V
	Gb.modulate = white
	Ab.modulate = white