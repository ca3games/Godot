extends Tabs

export(NodePath) var intervalbuttonpath
onready var intervalbutton = get_node(intervalbuttonpath)
onready var interval = preload("res://Scenes/Interval.tscn")
onready var rowintervalcontainer = preload("res://Scenes/IntervalContainer.tscn")

var notes = []
var offset = 0

func _ready():
	NewIntervals()
	SetKeyValues()

func ChangeName():
	var text = $Scale/ScaleName/NameString.text
	if text == "":
		$ScaleNameLabel.text = "new scale"
	else:
		$ScaleNameLabel.text = $Scale/ScaleName/NameString.text


func NewIntervals():
	var w = 0
	var lastrow
	var r = rowintervalcontainer.instance()
	$Scale/IntervalContainer.add_child(r)
	lastrow = r
	for i in intervalbutton.value:
		if w > 6:
			var row = rowintervalcontainer.instance()
			$Scale/IntervalContainer.add_child(row)
			lastrow = row
			w = 0
		var inter = interval.instance()
		lastrow.add_child(inter)
		w += 1

func SetKeyValues():
	notes = []
	var id = $Scale/IntervalContainer.get_children()
	var x = 0
	for i in id:
		var a = i.get_children()
		for b in a:
			notes.append([])
			notes[x] = b.value
			x += 1

func _on_SetIntervals_button_up():
	var c = $Scale/IntervalContainer.get_children()
	for i in len(c):
		$Scale/IntervalContainer.get_child(i).queue_free()
	NewIntervals()


func _on_Name_button_up():
	ChangeName()


func _on_Button_button_up():
	SetKeyValues()
	$"Scale/KeysLabel/Keys".text = str(notes)
