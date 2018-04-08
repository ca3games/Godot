extends Node

var z = -3
var level = 1
var score = 0
var record = 0
var lasttime = 99

func _gameover():
	if score > record:
		record = score
	get_tree().change_scene("res://Scenes/GameOver.tscn")
	
func _endlevel():
	lasttime = round(get_tree().get_root().get_node("Spatial/TIMER").get_time_left())
	get_tree().change_scene("res://Scenes/Bonus.tscn")

func _endleveltransition():
	get_tree().get_root().get_node("Spatial/Transition")._close()

func _startlevel():
	lasttime = 99
	get_tree().change_scene("res://Scenes/main.tscn")
	
func _barbounce(value):
	var tmp = get_tree().get_root().get_node("Spatial/SpecialBar").get_value();
	tmp += value
	get_tree().get_root().get_node("Spatial/SpecialBar").set_value(tmp);
	var button = get_tree().get_root().get_node("Spatial/Specialbutton").is_visible()
	if tmp >= 99:
		get_tree().get_root().get_node("Spatial/Specialbutton").show()
	
func _super():
	get_tree().get_root().get_node("Spatial/Ball")._super()
	get_tree().get_root().get_node("Spatial/Specialbutton").hide()
	get_tree().get_root().get_node("Spatial/SpecialBar").set_value(0);