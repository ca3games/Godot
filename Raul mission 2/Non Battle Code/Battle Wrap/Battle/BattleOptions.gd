extends OptionButton

export(PackedScene) var ActionButton
var Commands

func _ready():
	yield(get_tree(), "idle_frame")
	Commands = $"../../../".get_node("Menu/Commands")
	
	Addoption("ATTACK")
	Addoption("HEAL")
	Addoption("DEFEND")
	Addoption("PARRY")
	
	AddAction()

func AddAction():
	var action = "none"
	match(self.selected):
		0: action = "ATTACK"
		1: action = "HEAL"
		2: action = "DEFEND"
		3: action = "PARRY"
		
	var tmp = ActionButton.instance()
	tmp.text = action
	tmp.action = action
	Commands.add_child(tmp)
	
	
func DeleteCommand():
	var childs = Commands.get_child_count()
	if childs > 1:
		Commands.get_child(0).queue_free()

func Addoption(o):
	self.add_item(o)


func _on_AddAction_button_up():
	AddAction()
