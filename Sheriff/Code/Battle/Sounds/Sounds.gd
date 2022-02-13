extends Node2D

func GunShoot():
	$Battle/Gun.play()

func ChangeLevel():
	$Battle/BasicAmmo.stop()

func PlayGrunt(level):
	if level != 0:
		$Battle/Grunts.get_node(str(level)).play()
	else:
		$Battle/Grunts.get_node(str(1)).play()

func PlayAmmoBasic():
	$Battle/BasicAmmo.play()

func PlayEnemyHit():
	var x = randi()%3+1
	$Battle/Hits.get_node(str(x)).play()

func PlayPlayerHit():
	$Battle/AuchPlayer.play()
