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