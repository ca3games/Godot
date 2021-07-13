extends Timer

export(PackedScene) var Bullet


func _on_ShootTimer_timeout():
	start(randi()% 5 + 1)
	
	var tmp = Bullet.instance()
	tmp.position = $"../".position
	$"../".BulletsManager.add_child(tmp)
