extends Node2D

var bongo_cat = []
var offset = Vector2(250,250)
var cell = load("res://Scripts/Cell.gd")
onready var cat = preload("res://Scenes/BongoCat.tscn")
var camera_offset = Vector2(-150, -150)
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
	ShowNames(false)
	$Camera2D.position = Vector2(2 * offset.x, 2 * offset.y) + camera_offset

func _noteON(channel, program, note):
	var id = Vector2(channel%4, channel/4)
	bongo_cat[id.x][id.y].bongo_cat.show()
	if channel == 9 :
		bongo_cat[id.x][id.y].bongo_cat.Note_ON(note-35, program, channel)
		if note >= 35 and note <= 81:
			bongo_cat[id.x][id.y].bongo_cat.get_node("Name").text = names.percussion[note]
		else:
			bongo_cat[id.x][id.y].bongo_cat.get_node("Name").text = "percussion"
	else:
		bongo_cat[id.x][id.y].bongo_cat.get_node("Name").text = names.instrument[program]
		bongo_cat[id.x][id.y].bongo_cat.Note_ON(note%12, program, channel)
	
func _noteOFF(channel):
	var id = Vector2(channel%4, channel/4)
	bongo_cat[id.x][id.y].bongo_cat.Note_OFF(channel)

func HideCats():
	for x in range(0, 4):
		for y in range(0, 4):
			bongo_cat[x][y].bongo_cat.hide()
			
func ShowNames(boolean):
	for x in range(0, 4):
		for y in range(0, 4):
			if boolean:
				bongo_cat[x][y].bongo_cat.get_node("Name").show()
			else:
				bongo_cat[x][y].bongo_cat.get_node("Name").hide()