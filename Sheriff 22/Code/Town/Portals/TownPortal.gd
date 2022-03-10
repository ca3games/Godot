extends StaticBody

export(String) var VideoIntro = "res://Scenes/Story/Video1.tscn"
export(int) var Dif



func _on_TownPortal_body_entered(body):
	if body.is_in_group("PLAYER"):
		SetDificulty()
		get_tree().change_scene(VideoIntro)
		

func SetDificulty():
	match(Dif):
		0 : Variables.dificulty = 0.2
		1 : Variables.dificulty = 1.3
		2 : Variables.dificulty = 1.6
		3 : Variables.dificulty = 2.2
