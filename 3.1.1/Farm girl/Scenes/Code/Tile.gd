extends Spatial

func ChangeColor(color):
	$AnimatedSprite.modulate = color

func PrintHelp(color):
	$Info.modulate = color
	$Info.show()
	
func HideHelp():
	$Info.hide()
	$Info.modulate = Color.white

func Update(camera, text, text2):
	$Label.rect_position = camera.unproject_position(self.global_transform.origin)
	$Label.text = str(text)
	$Label/Info2.text = str(text2)
