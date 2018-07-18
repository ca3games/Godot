extends Sprite3D

func _ready():
	get_node("AnimationPlayer").play("bounce")

func _stop():
	self.queue_free()