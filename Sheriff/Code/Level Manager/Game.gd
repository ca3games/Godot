extends Node2D

onready var story = "res://Scenes/Story/STORY.tscn"
onready var battle = "res://Scenes/Battle/Battle.tscn"
onready var PreBattlePicture = "res://Scenes/Story/STORY picture.tscn"

func _on_Start_pressed():
	get_tree().change_scene(story)


func _on_StartBattle_pressed():
	get_tree().change_scene(battle)


func _on_story_picture_button_pressed():
	get_tree().change_scene(PreBattlePicture)
