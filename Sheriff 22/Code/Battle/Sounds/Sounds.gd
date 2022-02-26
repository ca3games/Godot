extends Node2D

func _ready():
	PlayBattleSong()

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

func PlayBattleSong():
	randomize()
	var x = randi()%3+1
	match(x):
		2: $Songs/Battle2.play()
		3: $Songs/Battle3.play()
		_: $Songs/Battle1.play()
	
func StopBattleSong():
	$Songs/Battle1.stop()
	$Songs/Battle2.stop()
	$Songs/Battle3.stop()


func _on_Battle1_finished():
	PlayBattleSong()

func _on_Battle2_finished():
	PlayBattleSong()

func _on_Battle3_finished():
	PlayBattleSong()
