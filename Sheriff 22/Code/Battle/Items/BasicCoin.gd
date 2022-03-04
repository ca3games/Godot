extends Area2D

export(int) var value

func _on_BasicCoin_body_entered(body):
	if body.is_in_group("PLAYER"):
		Variables.money += value
		get_parent().GUI.UpdateMoney()
		self.queue_free()


func _on_ExpensiveCoin_body_entered(body):
	if body.is_in_group("PLAYER"):
		Variables.money += value
		get_parent().GUI.UpdateMoney()
		self.queue_free()
