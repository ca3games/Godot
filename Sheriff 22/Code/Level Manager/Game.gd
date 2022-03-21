extends Node2D

onready var story = "res://Scenes/Story/STORY.tscn"
onready var battle = "res://Scenes/Battle/Maps/Roguelite/Level1.tscn"
onready var PreBattlePicture = "res://Scenes/Story/STORY picture.tscn"
onready var VideoIntro1 = "res://Scenes/Story/Video1.tscn"
onready var Title = "res://Scenes/Game.tscn"
onready var Town = "res://Scenes/BoardMap/BoardMap.tscn"

func _on_Start_pressed():
	get_tree().change_scene(VideoIntro1)


func _on_StartBattle_pressed():
	get_tree().change_scene(VideoIntro1)


func _on_story_picture_button_pressed():
	get_tree().change_scene(VideoIntro1)


func _VideoIntro1():
	get_tree().change_scene(battle)


func _on_GameOver_timeout():
	Variables.ResetVariables()
	get_tree().change_scene(Title)
