extends TextureProgress

func _ready():
	$Timer.start(60 * 3)

func _process(delta):
	self.value = $Timer.time_left / 3
	$"../Label".text = str(int($Timer.time_left / 3))


func _on_Timer_timeout():
	Variables.GameOver()
