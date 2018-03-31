extends Label

func _ready():
	var score = Global.score
	
	self.set_text(str(score))
	pass
