extends Label

func _ready():
	self.set_text("SCORE:  " + str(Global.score))

func _enemydead():
	self.set_text("SCORE:  " + str(Global.score))
