extends Node

onready var Ani = $"../../AnimationPlayer"
onready var Bullet = preload("res://Scenes/Particles/Enemy Bullet.tscn")
onready var Root = $"../.."

func _Update():
	if Ani.current_animation != "Shoot":
		Ani.play("Shoot")
		var tmp = Bullet.instance()
		tmp.global_transform.origin = Root.global_transform.origin
		var color = Root.mamerto_color
		if color.r == 0 and color.g == 0 and color.b == 0:
			color = Color(1,1,1,1)
		tmp._setColor(color)
		tmp.damage = Root.damage
		get_tree().get_root().add_child(tmp)
	
func _Physics():
	pass
	
func _end():
	Root._ChangeStatus("chase")