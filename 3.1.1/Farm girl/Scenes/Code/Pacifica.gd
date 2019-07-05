extends Spatial

func Move_Anim(move):
	$AnimatedSprite.animation = "IDLE"
	match (move):
		"front" : 
			$AnimatedSprite.frame = 1
			$AnimatedSprite.flip_h = false
		"left" :
			$AnimatedSprite.frame = 2
			$AnimatedSprite.flip_h = true
		"right" :
			$AnimatedSprite.frame = 2
			$AnimatedSprite.flip_h = false
		"back" :
			$AnimatedSprite.frame = 0
			$AnimatedSprite.flip_h = false