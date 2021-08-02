extends StaticBody

export (int) var DeadTime
export (int) var Damage

func _ready():
	$Timer.start(DeadTime)


func _on_Timer_timeout():
	self.queue_free()
