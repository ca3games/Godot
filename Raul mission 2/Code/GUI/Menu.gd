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

func _process(delta):
	if Input.is_action_just_released("BOMB"):
		shown = !shown
		selected = 0
		ClearPanels(Color.gray)
		Player.menushown = shown
		self.rect_position = Player.position
	
	if Input.is_action_just_released("UP"):
		if selected > 0:
			selected -= 1
		ClearPanels(Color.gray)
	if Input.is_action_just_released("DOWN"):
		if selected < max_id - 1:
			selected += 1
		ClearPanels(Color.gray)
	
	if shown:
		self.show()
	else:
		self.hide()
