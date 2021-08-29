extends KinematicBody2D

export (PackedScene) var Bullet

func SpawnDead():
	var chance = randi()%5+1
	if chance < 3:
		return
	var tmp = Bullet.instance()
	tmp.position = position
	$"../".add_child(tmp)
