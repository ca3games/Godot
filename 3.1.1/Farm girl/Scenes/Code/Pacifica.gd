extends Spatial

func Move_Anim(move):
	match (move):
		"front" : 
			$Pacifica.rotation_degrees = Vector3.ZERO
		"left" :
			$Pacifica.rotation_degrees = Vector3(0, 270, 0)
		"right" :
			$Pacifica.rotation_degrees = Vector3(0, 90, 0)
		"back" :
			$Pacifica.rotation_degrees = Vector3(0, 180, 0)
		"front left":
			$Pacifica.rotation_degrees = Vector3(0, 310, 0)
		"front right":
			$Pacifica.rotation_degrees = Vector3(0, 45, 0)
		"back left":
			$Pacifica.rotation_degrees = Vector3(0, 220, 0)
		"back right":
			$Pacifica.rotation_degrees = Vector3(0, 140, 0)
