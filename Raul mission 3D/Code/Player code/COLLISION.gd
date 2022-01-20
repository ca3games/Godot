extends Node


func _ready():
	pass


func _on_AttackBox_body_entered(body):
	if body.is_in_group("ENEMY"):
		body.HIT(Vector3.UP * 300)
