extends Node2D

onready var story = "res://Scenes/Story/STORY.tscn"
onready var battle = "res://Scenes/Battle/Battle.tscn"
onready var PreBattlePicture = "res://Scenes/Story/STORY picture.tscn"
onready var VideoIntro1 = "res://Scenes/Story/Video1.tscn"
onready var Title = "res://Scenes/Game.tscn"

func _ready():
	if is_instance_valid($Dificulty):
		$Dificulty.add_item("Easy")
		$Dificulty.add_item("Normal")
		$Dificulty.add_item("Hard")
		$Dificulty.add_item("YOULL DIE")

func _on_Start_pressed():
	get_tree().change_scene(story)


func _on_StartBattle_pressed():
	get_tree().change_scene(VideoIntro1)


func _on_story_picture_button_pressed():
	get_tree().change_scene(PreBattlePicture)


func _VideoIntro1():
	get_tree().change_scene(battle)


func _on_GameOverButton_pressed():
	Variables.ResetVariables()
	get_tree().change_scene(Title)


func _on_Dificulty_item_selected(index):
	match(index):
		0 : Variables.dificulty = 0.2
		1 : Variables.dificulty = 1.3
		2 : Variables.dificulty = 1.6
		3 : Variables.dificulty = 2.2
