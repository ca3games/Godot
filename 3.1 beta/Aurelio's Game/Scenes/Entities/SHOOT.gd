extends Node

onready var R = $"../../"
onready var A = $"../../AnimationPlayer"

func _MyInput():
	pass

func _Animation():
	match(R.direction):
		2: 
			if A.current_animation != "Front Pistol":
				A.play("Front Pistol")
		4: 
			if A.current_animation != "Side Left Pistol":
				A.play("Side Left Pistol")
		6: 
			if A.current_animation != "Side Right Pistol":
				A.play("Side Right Pistol")
		8: 
			if A.current_animation != "Back Pistol":
				A.play("Back Pistol")
		1: 
			if A.current_animation != "Front Diagonal Left Pistol":
				A.play("Front Diagonal Left Pistol")
		3: 
			if A.current_animation != "Front Diagonal Right Pistol":
				A.play("Front Diagonal Right Pistol")
		7: 
			if A.current_animation != "Back Dia Left Pistol":
				A.play("Back Dia Left Pistol")
		9: 
			if A.current_animation != "Back Dia Right Pistol":
				A.play("Back Dia Right Pistol")
	
func _Physics():
	R.linear_velocity = Vector3(0,0,0)
	
func _endShoot():
	R._ChangeStatus("idle")