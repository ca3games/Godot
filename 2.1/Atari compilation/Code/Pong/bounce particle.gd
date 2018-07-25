extends Particles2D

func _ready():
	self.set_emitting(true)

func _timeout():
	self.queue_free()
