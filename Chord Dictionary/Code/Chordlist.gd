extends Panel
var But = preload("res://scenes/Button.tscn")



func _ready():
	major()


func major():
	var root = get_node("ScrollContainer/List")
	
	var C = But.instance()
	C.text = "Cmaj"
	root.add_child(C)
	var Db = But.instance()
	Db.text = "C#maj"
	root.add_child(Db)
	var D = But.instance()
	D.text = "Dmaj"
	root.add_child(D)
	var Eb = But.instance()
	Eb.text = "D#maj"
	root.add_child(Eb)
	var E = But.instance()
	E.text = "Emaj"
	root.add_child(E)
	var F = But.instance()
	F.text = "Cmaj"
	root.add_child(F)
	var Gb = But.instance()
	Gb.text = "Cmaj"
	root.add_child(Gb)
	var G = But.instance()
	G.text = "Cmaj"
	root.add_child(G)
	var Ab = But.instance()
	Ab.text = "Cmaj"
	root.add_child(Ab)
	var A = But.instance()
	A.text = "Cmaj"
	root.add_child(A)
	var Bb = But.instance()
	Bb.text = "Cmaj"
	root.add_child(Bb)
	var B = But.instance()
	B.text = "Cmaj"
	root.add_child(B)
