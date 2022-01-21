extends Tabs

export(NodePath) var intervalbuttonpath
onready var intervalbutton = get_node(intervalbuttonpath)
onready var interval = preload("res://Scenes/Interval.tscn")
onready var rowintervalcontainer = preload("res://Scenes/IntervalContainer.tscn")

var data = { "scalename" : "new scale", "notes" : []}

func _ready():
	NewIntervals()
	SetKeyValuesNew()


func SetGUI(mydata):
	$ScaleNameLabel.text = data["scalename"]
	$Scale/Intervals/IntervalSize.value = len(data["notes"])
	

func ChangeName():
	data["scalename"] = $Scale/ScaleName/NameString.text
	if data["scalename"] == "":
		data["scalename"] = "new scale"
	
	$ScaleNameLabel.text = data["scalename"]


func LoadGUIReset(mydata):
	$ScaleNameLabel.text = data["scalename"]
	$Scale/Intervals/IntervalSize.value = len(data["notes"])
	$Scale/ScaleName/NameString.text = data["scalename"]
	
	var c = $Scale/IntervalContainer.get_children()
	for i in len(c):
		$Scale/IntervalContainer.get_child(i).queue_free()
	LoadIntervals()
	$"Scale/KeysLabel/Keys".text = str(data["notes"])


func SetIntervalList():
	for i in len(data["notes"]):
		print(data["notes"][i])


func LoadIntervals():
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
		inter.value = data["notes"][i]
		lastrow.add_child(inter)
		w += 1


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
		inter.value = 0
		lastrow.add_child(inter)
		w += 1

func SetKeyValuesNew():
	var mynotes = []
	var id = $Scale/IntervalContainer.get_children()
	var x = 0
	for i in id:
		var a = i.get_children()
		for b in len(a):
				mynotes.append([])
				mynotes[x] = 0
				a[b].value = mynotes[x]
				x += 1
	data["notes"] = mynotes


func SetKeyValues():
	var mynotes = []
	var id = $Scale/IntervalContainer.get_children()
	var x = 0
	for i in len(id):
		var a = id[i].get_children()
		for b in a:
			mynotes.append([])
			var value = int(b.value)
			mynotes[x] = value
			x += 1
	data["notes"] = mynotes

func _on_SetIntervals_button_up():
	var c = $Scale/IntervalContainer.get_children()
	for i in len(c):
		$Scale/IntervalContainer.get_child(i).queue_free()
	NewIntervals()
	SetKeyValuesNew()


func _on_Name_button_up():
	ChangeName()


func _on_Button_button_up():
	SetKeyValues()
	$"Scale/KeysLabel/Keys".text = str(data["notes"])


func _on_Save_button_up():
	get_tree().get_root().get_node("MIDITest/Save").show()


func _on_Save_file_selected(path):
	var tmp = File.new()
	tmp.open(path, File.WRITE)
	tmp.store_line(to_json(data))
	tmp.close()


func _on_Open_button_up():
	get_tree().get_root().get_node("MIDITest/Open").show()


func _on_Open_file_selected(path):
	var file = File.new()
	file.open(path, File.READ)
	var d = parse_json(file.get_as_text())
	data = d
	LoadGUIReset(data)


func _on_New_button_up():
	var c = $Scale/IntervalContainer.get_children()
	for i in len(c):
		$Scale/IntervalContainer.get_child(i).queue_free()
	data = { "scalename" : "new scale", "notes" : []}
	$ScaleNameLabel.text = data["scalename"]
	$Scale/Intervals/IntervalSize.value = 7
	$Scale/ScaleName/NameString.text = data["scalename"]
	NewIntervals()
	SetKeyValuesNew()
	$"Scale/KeysLabel/Keys".text = ""

