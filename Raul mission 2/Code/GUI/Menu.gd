extends Control

export(PackedScene) var Option
var shown = false
export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)
var selected = 0
var max_id = 4

func _ready():
	yield(get_tree(), "idle_frame")
	SpawnTest()
	ClearPanels(Color.gray)
	
func SpawnTest():
	SpawnOption(0, "TEST")
	SpawnOption(1, "TEST")
	SpawnOption(2, "TEST")
	max_id = len($Options.get_children())

func SpawnOption(id, menu):
	var tmp = Option.instance()
	var myname
	match(menu):
		"TEST" : myname  = $TestMenu.GetName(id)
	tmp.get_node("Option/Option").text = myname
	tmp.ID = id
	tmp.typemenu = menu
	$Options.add_child(tmp)

func ClearPanels(id):
	var panels = $Options.get_children()
	for i in len(panels):
		panels[i].ChangePanelColor(Color.black)
	panels[selected].ChangePanelColor(id)
