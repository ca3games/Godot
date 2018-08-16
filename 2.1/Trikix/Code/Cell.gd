extends Node2D

var x
var y

func _ready():
	pass

func _show():
	get_node("Sprite").show()

func _hide():
	get_node("Sprite").hide()

func _changeColor(colour):
	if colour == 0:
		get_node("AnimatedSprite").play("corazon")
	if colour == 1:
		get_node("AnimatedSprite").play("diamante")
	if colour == 2:
		get_node("AnimatedSprite").play("pica")
	if colour == 3:
		get_node("AnimatedSprite").play("trebol")
	if colour == 5:
		get_node("AnimatedSprite").play("empty")
		
func _clicked():
	get_node("/root/Node/Spawner")._MapClicked(x, y)

func _FOCUSON():
	get_node("/root/Node/Spawner")._FOCUSON(x, y)

func _FOCUSOFF():
	get_node("/root/Node/Spawner")._FOCUSOFF()
