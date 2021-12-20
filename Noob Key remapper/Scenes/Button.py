from godot import exposed, export
from godot import *


@exposed
class Button(Button):

	# member variables here, example:
	a = export(int)
	b = export(str, default='foo')

	
		"""
		Called every time the node is added to the scene.
		Initialization here.
		"""
		pass
