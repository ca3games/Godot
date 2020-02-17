extends TextureProgress


func _ready():
	pass


func _process(delta):
	
	var time_left = int($TimeTimer.time_left)
	$TimeLabel.text = str(time_left)
	self.value = time_left
	
func Hide():
	$TimeLabel.hide()
	self.hide()
	$TimeTimer.start(60)

func Show():
	$TimeLabel.show()
	self.show()
	$TimeTimer.start(60)


func _on_TimeButton_pressed():
	$TimeTimer.start(60)
	$"../".Mana.value -= 30
