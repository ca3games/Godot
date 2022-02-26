extends Sprite

func _ready():
	$Timer.start(3)

func Flip(h):
	if !h:
		flip_h = true

func SetColor(shirt, hat, pants, skin):
	self.material.set("shader_param/shirt_replace", shirt)
	self.material.set("shader_param/hat_replace", hat)
	self.material.set("shader_param/pants_replace", pants)
	self.material.set("shader_param/skin_replace", skin)

func _process(delta):
	var time = (3 - $Timer.time_left) / 3
	self.material.set("shader_param/dissolve_amount", time)


func _on_Timer_timeout():
	queue_free()
	pass
