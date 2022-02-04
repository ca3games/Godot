extends Node2D

export(PackedScene) var ActionButton
var selectedaction = 0

func _ready():
	yield(get_tree(), "idle_frame")
	
	Addoption()
	
	AddAction()

func _process(delta):
	if Input.is_action_just_released("ACTIONSELECT"):
		RotateList()
	if Input.is_action_pressed("LEFT") and Input.is_action_just_released("ACTIONSELECT"):
		SelectAction(0)
	if Input.is_action_pressed("RIGHT") and Input.is_action_just_released("ACTIONSELECT"):
		SelectAction(1)
	if Input.is_action_pressed("UP") and Input.is_action_just_released("ACTIONSELECT"):
		SelectAction(2)
	if Input.is_action_pressed("DOWN") and Input.is_action_just_released("ACTIONSELECT"):
		SelectAction(3)

func RotateList():
	selectedaction += 1
	if selectedaction >= 3:
		selectedaction = 0
	$Menu/MenuActions/ActionSelectLabel.text = GetSelectedString()

func SelectAction(i):
	selectedaction = i
	$Menu/MenuActions/ActionSelectLabel.text = GetSelectedString()
	
func GetSelectedString():
	var action = "none"
	match(selectedaction):
		0: action = "ATTACK"
		1: action = "HEAL"
		2: action = "DEFEND"
		3: action = "PARRY"
	return action


func AddAction():
	var action = GetSelectedString()
	var tmp = ActionButton.instance()
	tmp.get_node("Label").text = action
	tmp.action = action
	$Menu/MenuList.add_child(tmp)
	
	
func DeleteCommand():
	var childs = $Menu/MenuList.get_child_count()
	if childs > 1:
		$Menu/MenuList.get_child(0).queue_free()

func Addoption():
	$Menu/MenuActions/ActionSelectLabel.text = GetSelectedString()
