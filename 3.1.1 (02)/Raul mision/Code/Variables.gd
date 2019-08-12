extends Node

onready var playerattack = 10
var score = 0
onready var HP = 100
onready var TimeLeft = 200
onready var volume_music = 0
onready var volume_sounds = 0

const INPUT_ACTIONS = ["LEFT", "RIGHT", "TOP", "DOWN", "ATTACK", "X"]

func _ready():
	var dir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var config_file = ConfigFile.new()
	if config_file.load(dir + "/" + "Raul mission.cfg") != OK:
		Variables.volume_sounds = 0
		Variables.volume_music = 0
		config_file.set_value("RESOLUTION", "resolution", 2)
		config_file.save(dir + "/" + "Raul mission.cfg")
		
		var new = config_file.get_value("RESOLUTION", "resolution")
		OS.window_size = Vector2(350*new, 255*new)
	else:
		var new = config_file.get_value("RESOLUTION", "resolution")
		OS.window_size = Vector2(350*new, 255*new)
	

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