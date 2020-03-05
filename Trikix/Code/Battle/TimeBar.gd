extends TextureProgress

var max_time = 60

func _ready():
	self.max_value = max_time
	$Timer.start(max_time)
	$"../Levels".text = "LEVEL : 0"

func _process(delta):
	self.value = abs($Timer.time_left)

func AddPieceTimer():
	var newtime = self.value + 4
	if newtime > max_time:
		newtime = max_time
	$Timer.start(newtime)

func Combo():
	if Variables.score > 500:
		var level = int(Variables.score) / 500
		$"../Levels".text = "LEVEL : " + str(level)
		max_time -= 5
		$Timer.start(max_time)
	else:
		var newtime = self.value - 5
		if newtime < 0.5:
			newtime = 0.5
		$Timer.start(newtime)
	
