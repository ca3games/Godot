extends InterpolatedCamera

onready var nigga = $"../Nigga"
onready var targetlook = $"../Nigga/TargetCamera"

func _process(delta):
	self.look_at(targetlook.global_transform.origin, Vector3.UP)
	pass
