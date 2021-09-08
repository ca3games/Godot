extends Node


onready var admob = $AdMob
var namesong = "song"

func _ready():
	admob.load_banner()
	get_tree().connect("screen_resized", self, "_on_resize")
	admob.show_banner()

onready var Level = 1
export(String) var BattleWin
export(String) var BattleLost

var score = 0
var MaxSCORE = 0

onready var HP = 100

func Add_score(new_score):
	score += int(new_score)
	get_tree().get_root().get_node("Battle/Buttons/InfoTOP/SCORE/SCORE").text = str(score)

func WinLevel():
	Level += 1
	get_tree().change_scene(BattleWin)

func StartBattle():
	Level = 1
	score = 0
	HP = 100
	get_tree().change_scene(BattleWin)

func GameOver():
	Level = 1
	HP = 100
	if score > MaxSCORE:
		MaxSCORE = score
	get_tree().change_scene(BattleLost)

func PlaySUN():
	$SUN.play()
