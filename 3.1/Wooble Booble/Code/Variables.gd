extends Node

var level = 0
var score = 0
var tweenscore = 0

onready var scoretween = get_tree().get_root().get_node("Root/GUI/ScoreTween")
onready var scorelabel = get_tree().get_root().get_node("Root/GUI/Score")

func _deadBall():
	var enemies = get_tree().get_nodes_in_group("Enemy").size()
	if enemies < 2:
		level += 1
		get_tree().get_root().get_node("Root/Transition")._ToLeave()
		get_tree().paused = true

func ChangeScene():
	get_tree().change_scene("res://Scenes/Level.tscn")

func GameOver():
	get_tree().change_scene("res://Scenes/GameOver.tscn")

func TimeOver():
	get_tree().change_scene("res://Scenes/GameOver.tscn")
	
func SetLeftLabel():
	var enemies = get_tree().get_nodes_in_group("Enemy").size() - 1
	if enemies == 0 :
		enemies = 1
	get_tree().get_root().get_node("Root/GUI/Left").text = str(enemies)

func SetLeftText(enemies):
	get_tree().get_root().get_node("Root/GUI/Left").text = str(enemies)
	

func  SetTimeLabel():
	var time = int(get_tree().get_root().get_node("Root/TimeLeft").time_left / 3)
	get_tree().get_root().get_node("Root/GUI/Time").text = str(time)
	
func GetTimeLeft():
	return get_tree().get_root().get_node("Root/TimeLeft").time_left
	
	
func SetScoreLabel():
	get_tree().get_root().get_node("Root/GUI/Score").text = str(score)
	
func TweenScoreLabel(number):
	tweenscore = int(get_tree().get_root().get_node("Root/GUI/Score").text)
	score += number
	get_tree().get_root().get_node("Root/GUI/Score").set("custom_colors/font_color", Color8(255, 0, 0))
	get_tree().get_root().get_node("Root/GUI/ScoreTween").interpolate_method(self, "ScoreTween", tweenscore, score, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	get_tree().get_root().get_node("Root/GUI/ScoreTween").start()

func ScoreTween(number):
	get_tree().get_root().get_node("Root/GUI/Score").text = str(int(number))

func StartGame():
	get_tree().change_scene("res://Scenes/Level.tscn")