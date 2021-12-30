extends Panel


export(Rect2) var Area
var recording = false
var mouse = false

func _ready():
	pass
	
func _process(delta):
	if recording and mouse:
		$Dot.rect_global_position = get_global_mouse_position()


func _on_TriggerArea_mouse_entered():
	mouse = true


func _on_TriggerArea_mouse_exited():
	mouse = false

func GetX():
	var x = $Center.rect_position.x - $Dot.rect_position.x
	return x
