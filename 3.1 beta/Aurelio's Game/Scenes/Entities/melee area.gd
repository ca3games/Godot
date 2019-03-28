extends Area

onready var hitstun = get_tree().get_root().get_node("Spatial/HitStun")

func _MeleeHit(body):
	if body.is_in_group("Mamerto"):
		$"../".HitSound()
		hitstun._GetHit()
		body._PistolHit(3)
		get_tree().get_root().get_node("Spatial")._SetEnemyCount()
