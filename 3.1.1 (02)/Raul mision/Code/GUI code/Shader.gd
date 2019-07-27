extends TextureRect


func Start():
	self.show()
	$Tween.interpolate_method(self, "SetX", 1, 80, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
func End():
	self.show()
	$Tween.interpolate_method(self, "SetX", 80, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	self.hide()
	
func SetX(new):
	self.material.set("shader_param/size_x", new)