extends Node2D

var x
var y
var empty = true
var colour = 5
var ComboCheck = false
onready var TweenNode = get_node("Tween")
onready var TweenSolid = get_node("Solid")

func _ready():
	pass

func _show():
	get_node("Sprite").show()

func _hide():
	get_node("Sprite").hide()

func _changeColor(c):
	if c == 0:
		get_node("AnimatedSprite").play("corazon")
		empty = false
		colour = 0
	if c == 1:
		get_node("AnimatedSprite").play("diamante")
		empty = false
		colour = 1
	if c == 2:
		get_node("AnimatedSprite").play("pica")
		empty = false
		colour = 2
	if c == 3:
		get_node("AnimatedSprite").play("trebol")
		empty = false
		colour = 3
	if c == 5:
		get_node("AnimatedSprite").play("empty")
		colour = 5
		empty = true
	if c == 9:
		get_node("AnimatedSprite").play("combo")
		colour = 5
		empty = true
		
func _clicked():
	get_node("/root/Node/Spawner")._MapClicked(x, y)

func _FOCUSON():
	get_node("/root/Node/Spawner")._FOCUSON(x, y)

func _FOCUSOFF():
	get_node("/root/Node/Spawner")._FOCUSOFF()

func _empty():
	return empty

func getColor():
	return colour

func _tween_complete( object, key ):
	_changeColor(5)
	ComboCheck = false
	get_node("AnimatedSprite").set_scale(Vector2(1,1))
	get_node("AnimatedSprite").set_offset(Vector2(16,16))
	TweenSolid.interpolate_property(get_node("AnimatedSprite"), "visibility/opacity", 0, 1, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	TweenSolid.start()
	
func _combo():
	get_node("AnimatedSprite").play("combo")
	TweenNode.interpolate_property(get_node("AnimatedSprite"), "visibility/opacity", 1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	TweenNode.interpolate_property(get_node("AnimatedSprite"), "transform/scale", Vector2(1,1), Vector2(0,0), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	TweenNode.interpolate_property(get_node("AnimatedSprite"), "offset", Vector2(16,16), Vector2(40,40), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	TweenNode.start()	
