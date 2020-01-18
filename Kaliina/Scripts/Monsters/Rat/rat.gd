extends RigidBody

onready var HP = 20
var damage_hurt = 0

func _ready():
	$"Healthbar".texture = $"Healthbar/Viewport".get_texture()



func _on_ChangeStatus_timeout():
	var time = rand_range(1, 3)
	$ChangeStatus.start(time)
	$States.ChangeStatusRandom()

func Hurt(time, damage):
	$GetHurt.start(time)
	damage_hurt = damage


func _on_GetHurt_timeout():
	HP -= damage_hurt
	$"Healthbar/Viewport/Healthbar".value = HP
	
	if HP < 1:
		self.queue_free()
