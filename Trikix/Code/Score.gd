extends Label

func _ready():
	pass

func _text(text):
	set_text(text)

func _enter_tree():
	Values._begin()
