extends Node
onready var Root = $"../.."
onready var Ani = $"../../AnimationPlayer"

func _MyInput():
	pass

func _Animation():
	match(Root.direction):
		2:
			if Ani.current_animation != "Front Knife":
				Ani.play("Front Knife")
		1:
			if Ani.current_animation != "Front Dia Knife Left":
				Ani.play("Front Dia Knife Left")
		3:
			if Ani.current_animation != "Front Dia Knife Right":
				Ani.play("Front Dia Knife Right")
		4:
			if Ani.current_animation != "Side Knife Left":
				Ani.play("Side Knife Left")
		6:
			if Ani.current_animation != "Side Knife Right":
				Ani.play("Side Knife Right")
		7:
			if Ani.current_animation != "Back Dia Knife Left":
				Ani.play("Back Dia Knife Left")
		9:
			if Ani.current_animation != "Back Dia Knife Right":
				Ani.play("Back Dia Knife Right")
		8:
			if Ani.current_animation != "Back Knife":
				Ani.play("Back Knife")

func _Physics():
	Root.linear_velocity = Vector3(0,0,0)
	
func _end():
	Root._ChangeStatus("idle")