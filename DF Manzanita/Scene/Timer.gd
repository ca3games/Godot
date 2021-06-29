extends TextureProgress

signal apple_killed

func _ready():
	var generator = $"../../Generator"
	self.connect("apple_killed", generator, "_apple_killed")
	ResetTimer()

func _process(delta):
	self.value = $Timer.time_left

func ResetTimer():
	$Timer.start(12)
	$"../../".LOSE()
	$"../../AnimationPlayer".play("ResetTime")


func _on_Timer_timeout():
	ResetTimer()
