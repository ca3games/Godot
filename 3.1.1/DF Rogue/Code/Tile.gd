extends Node2D

func _ready():
	HidePlayer()
	$Door.hide()

func MakeWall():
	$Tile.modulate = Color.brown

func MakeWhite():
	$Tile.modulate = Color.white

func HidePlayer():
	$BadGuy.hide()

func ShowPlayer():
	$BadGuy.show()

func ShowDoor():
	$Door.show()

func MakeBlue():
	$Tile.modulate = Color.blue
	
func Colorize(color):
	$Tile.modulate = color

func Transparency(HP):
	$Tile.modulate = Color8(131, 51, 7, HP * 25)
	
func Info(text):
	$Info.text = str(text)