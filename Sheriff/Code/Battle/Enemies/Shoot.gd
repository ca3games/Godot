extends Node2D

export(PackedScene) var BasicBullet


func SpawnBullet():
	var tmp = BasicBullet.instance()
	var spawn = $SpawnShoot.global_position + $"../../".global_position
	tmp.global_position = spawn
	var normal = (spawn - $"../../../".Player.global_position - $"../../../".Player.OffsetBody).normalized()
	tmp.direction = normal
	tmp.damage = (($"../../".level * 2) + (Variables.level * 2) ) * Variables.dificulty
	tmp.speed = ((($"../../".level / 2) + (Variables.level / 3)) / 5 + 1 ) * Variables.dificulty
	$"../../../".EnemyBullet.add_child(tmp)


func _on_Bullet_timeout():
	var time = 10 - $"../../".level
	$"../".start(rand_range(0.5, time + 0.7))
	SpawnBullet()
