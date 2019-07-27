extends Node

onready var playerattack = 10
var score = 0
onready var HP = 100
onready var TimeLeft = 200

func ResetMap():
	if get_tree().get_root().get_node("Map/Shader") != null:
		$BetweenScenes.start(1.1)
		get_tree().get_root().get_node("Map/Shader").Start()
		yield($BetweenScenes, "timeout")
	TimeLeft -= 10
	get_tree().change_scene("res://Scenes/Level/Test.tscn")
	
func GameOver():
	var tweennode = get_tree().get_root().get_node("Map/Dead/Tween")
	var dead = get_tree().get_root().get_node("Map/Dead")
	dead.show()
	tweennode.interpolate_property(dead, "modulate", Color8(255,255,255,0), Color8(255,255,255,255), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweennode.start()
	yield(tweennode, "tween_completed")
	get_tree().change_scene("res://Scenes/Menues/GAMEOVER.tscn")

func Back():
	print("BACK")
	get_tree().change_scene("res://Scenes/Menues/TITLE.tscn")

func StartGame():
	playerattack = 10
	score = 0
	HP = 100
	TimeLeft = 300
	ResetMap()