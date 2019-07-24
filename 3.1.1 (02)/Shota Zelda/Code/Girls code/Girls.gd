extends KinematicBody2D

onready var current = get_node("Candy")
enum girl {
	candy, aisha, anna, cadence, jasmene, leia, maria, mia
	}
onready var current_girl = girl.candy
var menu = false
var id = 0

func _ready():
	$Sprite.hide()
	HideAll()
	SetGirlId()
	

func _process(delta):
	if Input.is_action_just_released("ESC"):
		menu = !menu
		if menu :
			get_tree().paused = true
			$Sprite.show()
		else :
			$Sprite.hide()
			get_tree().paused = false
	
	if menu :
		if Input.is_action_just_released("LEFT"):
			if id > 0:
				id -= 1
				HideAll()
				SetGirlId()
		if Input.is_action_just_released("RIGHT"):
			if id < len(girl)-1:
				id += 1
				HideAll()
				SetGirlId()

func HideAll():
	$Candy.hide()
	$Aisha.hide()
	$Anna.hide()
	$Cadence.hide()
	$Jasmene.hide()
	$LEIA.hide()
	$Maria.hide()
	$Mia.hide()

func SetGirlId():
	match(id):
		0 : SetGirl("candy")
		1 : SetGirl("aisha")
		2 : SetGirl("anna")
		3 : SetGirl("cadence")
		4 : SetGirl("jasmene")
		5 : SetGirl("leia")
		6 : SetGirl("maria")
		7 : SetGirl("mia")

func SetGirl(name):
	match(name):
		"candy" :
			$Candy.show()
			current = $Candy
			current_girl = girl.candy
		"aisha" :
			$Aisha.show()
			current = $Aisha
			current_girl = girl.aisha
		"anna" :
			$Anna.show()
			current = $Anna
			current_girl = girl.anna
		"cadence" :
			$Cadence.show()
			current = $Cadence
			current_girl = girl.cadence
		"jasmene" :
			$Jasmene.show()
			current = $Jasmene
			current_girl = girl.jasmene
		"leia" :
			$LEIA.show()
			current = $LEIA
			current_girl = girl.leia
		"maria" :
			$Maria.show()
			current = $Maria
			current_girl = girl.maria
		"mia" :
			$Mia.show()
			current = $Mia
			current_girl = girl.mia