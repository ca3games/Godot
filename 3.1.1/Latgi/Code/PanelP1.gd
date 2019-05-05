extends Panel

var style = StyleBoxFlat.new()

func ChangeColor(new_color):
	style.set_bg_color(new_color)
	add_stylebox_override("panel", style)