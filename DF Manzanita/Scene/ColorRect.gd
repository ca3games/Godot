extends ColorRect

var black = false
var finished = true

func _ready():
	Turn_on()

func _process(delta):
	if Input.is_action_just_released("SPACE") and finished:
		Turn_on()
	
func Turn_on():
	var alpha = 0
	var obscure = 255
	if black:
		alpha = 255
		obscure = 0
	
	$"Tween".interpolate_property(self, "color", Color8(0,  1, 29, alpha), Color8(0,  1, 29, obscure), 3, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$"Tween".start()
	
	finished = false




func _on_Tween_tween_all_completed():
	finished = true
	black = !black
