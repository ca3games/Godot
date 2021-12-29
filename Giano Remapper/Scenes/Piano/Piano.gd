extends Node2D

export(int) var PianoSize
export(PackedScene) var NoteScene
var Keyboard = []
export(Rect2) var size

func _ready():
	SpawnPiano()

func SpawnPiano():
	var offset = 0
	
	for i in PianoSize:
		var note = NoteScene.instance()
		Keyboard.append([])
		Keyboard[i] = note
	for i in PianoSize:
		offset += SpawnNote(i, offset)
	offset = 0
	for i in PianoSize:
		offset += SpawnBlack(i, offset)
		pass

func SpawnNote(key, offset):
	var n = key % 12

	if n == 1 or n == 3 or n == 6 or n == 8 or n == 10:
		return 0
	
	
	var h = offset * (size.size.x)
	var pos = Vector2((size.position.x * key) - h, 0)
	if n > 4:
		pos = Vector2((size.position.x * (key+1 )) - h, 0)
	
	Keyboard[key].rect_position = pos
	Keyboard[key].rect_size = Vector2(size.size.x, size.size.y)
	add_child(Keyboard[key])
	if key > 11:
		return 0
	return 1

func SpawnBlack(key, offset):
	var n = key % 12
	if not(n == 1 or n == 3 or n == 6 or n == 8 or n == 10):
		return 0

	var black_y = 0.5
	Keyboard[key].rect_position = Vector2((size.position.x * key) - (offset * size.size.x) - (size.size.x * 0.5), 0)
	Keyboard[key].rect_size = Vector2(size.size.x, size.size.y * black_y)
	Keyboard[key].color = Color.black
	add_child(Keyboard[key])
	return 1

func TurnOn(key):
	if key == 999:
		return
	else:
		Keyboard[key%12].color = Color.darkgreen
	
func TurnOff(key):
	if key == 999:
		return
	var n = key % 12
	if n == 1 or n == 3 or n == 6 or n == 8 or n == 10:	
		Keyboard[n].color = Color.black
	else:
		Keyboard[n].color = Color.white
