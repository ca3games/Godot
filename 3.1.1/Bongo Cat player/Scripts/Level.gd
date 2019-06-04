extends Node2D

var bongo_cat = []
var offset = Vector2(250,250)
var cell = load("res://Scripts/Cell.gd")
onready var cat = preload("res://Scenes/BongoCat.tscn")
var camera_offset = Vector2(-150,-250)
var MIDI_names = load("res://Scripts/MIDInames.gd")
var names

func _ready():
	names = MIDI_names.new()
	for x in range(0, 4):
		bongo_cat.append([])
		for y in range(0, 4):
			bongo_cat[x].append([])
			var block = cell.new()
			block.pos = Vector2(x, y)
			block.position = Vector2(x * offset.x, y * offset.y)
			block.bongo_cat = cat.instance()
			block.bongo_cat.transform.origin = block.position
			bongo_cat[x][y] = block
			self.add_child(bongo_cat[x][y].bongo_cat)
			bongo_cat[x][y].bongo_cat.hide()
	
	$Camera2D.position = Vector2(2 * offset.x, 2 * offset.y) + camera_offset

func _noteON(channel, program, note):
	var id = Vector2(channel%4, channel/4)
	bongo_cat[id.x][id.y].bongo_cat.show()
	bongo_cat[id.x][id.y].bongo_cat.Note_ON(note%12, program)
	if channel == 9 :
		if note >= 35 and note <= 81:
			bongo_cat[id.x][id.y].bongo_cat.get_node("Name").text = names.percussion[note]
		else:
			bongo_cat[id.x][id.y].bongo_cat.get_node("Name").text = "percussion"
	else:
		bongo_cat[id.x][id.y].bongo_cat.get_node("Name").text = names.instrument[program]
	
	
func _noteOFF(channel):
	var id = Vector2(channel%4, channel/4)
	bongo_cat[id.x][id.y].bongo_cat.Note_OFF()

func HideCats():
	for x in range(0, 4):
		for y in range(0, 4):
			bongo_cat[x][y].bongo_cat.hide()