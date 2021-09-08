extends Node2D


onready var tween = $Tween


func _ready():
	$Buttons/InfoTOP/SCORE/SCORE.text = str(Variables.score)
	tween.interpolate_property($BLACK, "color", Color8(0,0,0,255), Color8(0,0,0,0), 1, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	tween.start()
	SetSongName(Variables.namesong)

func SetSongName(name):
	$Buttons/Song.text = "song: " + name
