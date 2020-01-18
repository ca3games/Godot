extends Node2D

var pos

func Colorize(color):
	$Tile.modulate = color

func _on_TextureButton_pressed():
	get_tree().get_root().get_node("Map").MakeWallPos(pos)
	
func HideInfo():
	$Label.hide()

func Print(text):
	$Label.show()
	$Label.text = str(text)
