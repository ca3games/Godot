extends Node2D

export(NodePath) var AnimatedSpritePath
onready var AnimSprite = get_node(AnimatedSpritePath)

export(Color) var jacket01
export(Color) var jacket02
export(Color) var jacket03

export(Color) var Hat01
export(Color) var Hat02
export(Color) var Hat03

export(Color) var Pants01
export(Color) var Pants02
export(Color) var Pants03

export(Color) var Skin01
export(Color) var Skin02
export(Color) var Skin03

func _ready():
	yield(get_tree(), "idle_frame")
	var id = GetLevel()
	SetColor(id)
	$"../".level = id
		
func SetColor(level):
	match(level):
		1 : ChangeColor(jacket01, Hat01, Pants01, Skin01)
		2 : ChangeColor(jacket02, Hat01, Pants01, Skin01)
		3 : ChangeColor(jacket01, Hat02, Pants01, Skin01)
		4 : ChangeColor(jacket01, Hat01, Pants02, Skin02)
		5 : ChangeColor(jacket02, Hat02, Pants01, Skin01)
		6 : ChangeColor(jacket01, Hat02, Pants02, Skin01)
		7 : ChangeColor(jacket01, Hat01, Pants02, Skin02)
		8 : ChangeColor(jacket03, Hat03, Pants03, Skin03)
		9 : ChangeColor(jacket02, Hat02, Pants03, Skin03)
		10 : ChangeColor(jacket01, Hat02, Pants02, Skin03)
	

func ChangeColor(jacket, hat, pants, skin):
	AnimSprite.material.set("shader_param/shirt_replace", jacket)
	AnimSprite.material.set("shader_param/hat_replace", hat)
	AnimSprite.material.set("shader_param/pants_replace", pants)
	AnimSprite.material.set("shader_param/skin_replace", skin)

func GetLevel():
	var level = 1
	
	level = randi()%10 + 1
	
	return level
