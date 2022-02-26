extends Node2D

onready var talk_type = randi()%3 + 1

export(Array, String) var phrase

func _ready():
	$Show.start(rand_range(3, 10))
	$Label.hide()
	$Panel.hide()

func ChangeText():
	var i = randi()%(len(phrase))-1
	var t = phrase[i]
	$Label.text = t

func GetTime():
	var time = 3
	match(talk_type):
		1 : return rand_range(3, 5)
		2 : return rand_range(8, 15)
		3 : return rand_range(20, 30)
		_: return 35


func _on_Show_timeout():
	$Show.start(GetTime())
	ChangeText()
	$Label.show()
	$Panel.show()
	$Hide.start(2)


func _on_Hide_timeout():
	$Label.hide()
	$Panel.hide()
