extends Spatial

onready var Root = $".."
onready var Ani = $"../../AnimationPlayer"

func Update(delta):
	if !Ani.is_playing() and Ani.current_animation != "SEEDING":
		Ani.play("SEEDING")
	
func Physics(delta):
	pass

func END():
	$"../..".SEED()
	Root.ChangeState("IDLE")
