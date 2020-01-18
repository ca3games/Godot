extends Spatial

func _ready():
	HideInfo()

func ModulateColor(color):
	$Sprite3D.set("modulate", color)
	
func ModulateInfo(color):
	$Info.show()
	$Info.set("modulate", color)
	
func HideInfo():
	$Info.hide()