extends Position2D

var Left = false
var Right = false

func _input(event):
	if event is InputEventMouseMotion:
		self.position = event.position

func _process(delta):
	if Left:
		$"../../".rotate_y(deg2rad(1))
	if Right:
		$"../../".rotate_y(deg2rad(-1))

func _on_LEFT_mouse_entered():
	Left = true

func _on_LEFT_mouse_exited():
	Left = false

func _on_RIGHT_mouse_entered():
	Right = true

func _on_RIGHT_mouse_exited():
	Right = false
