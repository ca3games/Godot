extends Node

onready var sky = $sky
onready var clouds = $clouds
onready var star = $starsopacity
var sky_dir = 0
var clouds_dir = 0
var stars = 0

func _ready():
	Sky()
	Clouds()
	Stars()

func Stars():
	match(stars):
		0:
			star.interpolate_property($Sky, "modulate", Color8(255, 255, 255, 80), Color8(255,255,255,150), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			stars = 1
		1:
			star.interpolate_property($Sky, "modulate", Color8(255, 255, 255, 150), Color8(255,255,255,80), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			stars = 2
		2:
			star.interpolate_property($Sky, "modulate", Color8(255, 255, 255, 80), Color8(255,255,255,150), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			stars = 1
	star.start()

func Clouds():
	match(clouds_dir):
		0:
			clouds.interpolate_property($Clouds, "modulate", Color8(255, 255, 255, 28), Color8(255,255,255,8), 3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			clouds_dir = 1
		1:
			clouds.interpolate_property($Clouds, "modulate", Color8(255, 255, 255, 8), Color8(255,255,255,20), 3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			clouds_dir = 2
		2:
			clouds.interpolate_property($Clouds, "modulate", Color8(255, 255, 255, 20), Color8(255,255,255,8), 3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			clouds_dir = 1
	clouds.start()

func Sky():
	match(sky_dir):
		0: 
			sky.interpolate_property($Sky, "translation", Vector3(0, -0.7, 0), Vector3(-0.3, -0.7, 0), 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			sky_dir = -1
		-1:
			sky.interpolate_property($Sky, "translation", Vector3(-0.3, -0.7, 0), Vector3(0.3, -0.7, 0), 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			sky_dir = 1
		1:
			sky.interpolate_property($Sky, "translation", Vector3(0.3, -0.7, 0), Vector3(-0.3, -0.7, 0), 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			sky_dir = -1
	sky.start()

func _on_sky_tween_completed(object, key):
	Sky()

func _on_clouds_tween_completed(object, key):
	Clouds()


func _on_starsopacity_tween_completed(object, key):
	Stars()
