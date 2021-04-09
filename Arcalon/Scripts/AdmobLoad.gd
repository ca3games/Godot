extends Node2D

onready var admob = $AdMob

func _ready():
	admob.load_banner()

