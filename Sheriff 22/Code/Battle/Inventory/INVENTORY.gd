extends Node2D

onready var menuopen = false
onready var id = 0

func _ready():
	TURNOFF()
	$Weapons.CleanSelection()
	$Weapons.TurnH(id)
	for i in Variables.GunsMax():
		var d = Variables.GetGun(i)
		$Weapons.SetItem(i, d, Variables.GetAmmo(d))
	UpdateAMMO()

func UpdateAMMO():
	for i in 6:
		$Weapons.UpdateAMMO(i)

func TURNON():
	menuopen = true
	$"3D Guns".TURNON()

func TURNOFF():
	menuopen = false
	$"3D Guns".TURNOFF()

func _process(delta):
	if not menuopen:
		return
	
	var left = false
	var right = false
	var up = false
	var down = false
	
	if Input.is_action_just_released("LEFT"):
		left = true
	if Input.is_action_just_released("RIGHT"):
		right = true
	if Input.is_action_just_released("UP"):
		up = true
	if Input.is_action_just_released("DOWN"):
		down = true
	
	if left and id >= 1:
		id -= 1
	if right and id <= 4:
		id += 1
		
	if left or right or up or down:
		$Weapons.CleanSelection()
		$Weapons.TurnH(id)
