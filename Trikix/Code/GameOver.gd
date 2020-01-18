extends TextureButton

func _ready():
	get_node("/root/Node/Last").set_text(str(Values.score))
	
	print ("score " + str(Values.score) + " / record " + str(Values.recordscore))
	if Values.score > Values.recordscore:
		Values.recordscore = Values.score
	print ("SAVED")
	print ("score " + str(Values.score) + " / record " + str(Values.recordscore))
	
	get_node("/root/Node/Record").set_text(str(Values.recordscore))


func _pressed():
	get_tree().change_scene("res://Scenes/GameTitle.tscn")
